import 'dart:convert';
import 'dart:developer';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:dio/dio.dart';

import 'package:hive/hive.dart';

class AuthProvider {
  Dio dio = Dio();
  final Box authBox = Hive.box('auth');
  AuthProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = getRefreshToken();
            if (refreshToken != null) {
              final success = await _refreshToken(refreshToken);
              if (success) {
                // Retry the failed request with the new access token
                final retryOptions = e.requestOptions;
                retryOptions.headers['Authorization'] =
                    'Bearer ${getAccessToken()}';
                final response = await dio.request(
                  retryOptions.path,
                  options: Options(
                    method: retryOptions.method,
                    headers: retryOptions.headers,
                  ),
                  data: retryOptions.data,
                  queryParameters: retryOptions.queryParameters,
                );
                return handler.resolve(response);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final Response response = await dio.post(
        '${url}users/auth/refresh',
        data: json.encode({'refresh': refreshToken}),
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        final newRefreshToken = response.data['refresh'];
        if (newAccessToken != null && newRefreshToken != null) {
          await authBox.put('accessToken', newAccessToken);
          await authBox.put('refreshToken', newRefreshToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int?> register({
    String? phone,
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
    String? password,
  }) async {
    print("""  {
            'phone': $phone ?? '+99365671855',
            'name': $name ?? 'Merdan',
            'address': $address ?? 'some text data',
            'birthday': $birthday ?? '1991-01-01',
            'email': null,
            'gender': $gender ?? 'male',
            'password': $password,
          },""");
    try {
      final Response response = await dio.post(
        '${url}users/auth/sign-up',
        data: json.encode(
          {
            'phone': phone ?? '+99365671855',
            'name': name ?? 'Merdan',
            'address': address ?? 'some text data',
            'birthday': birthday ?? '1991-01-01',
            'email': null,
            'gender': gender ?? 'male',
            'password': password,
          },
        ),
      );
      print("""  {
            'phone': $phone ?? '+99365671855',
            'name': $name ?? 'Merdan',
            'address': $address ?? 'some text data',
            'birthday': $birthday ?? '1991-01-01',
            'email': null,
            'gender': $gender ?? 'male',
            'password': $password,
          },""");
      return response.data['statusCode'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> otp({String? phone, int? otp}) async {
    try {
      final Response response = await dio.post(
        '${url}users/auth/check-otp',
        data: json.encode({'phone': '+993$phone', 'otp': otp}),
      );

      if (response.statusCode == 201) {
        // Type-safe access
        final Map<String, dynamic>? data =
            response.data['data'] as Map<String, dynamic>?;

        final Map<String, dynamic>? token =
            data?['token'] as Map<String, dynamic>?;

        if (data != null && token != null) {
          // Use optional chaining to handle potential nulls
          final accessToken = token['access'];
          final refreshToken = token['refresh'];

          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
          }
        } else {
          // Throw more informative exceptions
          throw Exception('Invalid response data. Missing user or token.');
        }
        return response.data['statusCode'] as int?;
      } else {
        throw Exception(
          'OTP request failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during OTP request: ${e.toString()}');
    }
  }

  Future<int?> signIn({String? phone, String? password}) async {
    try {
      final Response response = await dio.post(
        '${url}users/auth/sign-in',
        data: json.encode(
          {'phone': '$phone', 'password': password},
        ),
      );
      if (response.data['statusCode'] == 200) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
          }
        }
      }

      return response.data['statusCode'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Data?> changePass({String? oldPass, String? newPass}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getAccessToken()}',
      'Cookie': 'i18n_redirected=tk',
    };

    try {
      final responseData = {'oldPassword': oldPass, 'newPassword': newPass};
      final Response response = await dio.post(
        '${url}users/auth/change-password',
        data: json.encode(responseData),
        options: Options(headers: headers),
      );
      log('it is chnage pass ${response.data['statusCode']}');

      if (response.data['statusCode'] == 200) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
          }
        }
        return Data.fromJson(data);
      } else if (response.data['statusCode'] == 401) {
        final success = await _refreshToken(getRefreshToken()!);
        if (success) {
          headers['Authorization'] = 'Bearer ${getAccessToken()}';
          final retryResponse = await dio.post(
            '${url}users/auth/change-password',
            data: json.encode(responseData),
            options: Options(headers: headers),
          );
          if (retryResponse.data['statusCode'] == 200) {
            final data = retryResponse.data['data'];
            if (data != null) {
              final accessToken = data['token']?['access'];
              final refreshToken = data['token']?['refresh'];
              if (accessToken != null && refreshToken != null) {
                await authBox.put('accessToken', accessToken);
                await authBox.put('refreshToken', refreshToken);
              }
            }
            return Data.fromJson(data);
          } else {
            throw Exception('Failed to change password after refreshing token');
          }
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<Data> updateUserData({
    required String? name,
    required String? birthday,
    required String? email,
    required String? gender,
    final String? address,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'name': name ?? '',
        'address': address ?? 'upd-address',
        'birthday': birthday ?? '',
        'email': null,
        'gender': gender ?? '',
      };
      print('huhuu');
      log(requestData.toString());

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getAccessToken()}',
        'Cookie': 'i18n_redirected=tk',
      };

      final Response response = await dio.post(
        '${url}users/auth/update',
        data: json.encode(requestData),
        options: Options(headers: headers),
      );
      print(requestData);
      log(requestData.toString());
      if (response.statusCode == 201) {
        final data = response.data['data'];

        return Data.fromJson(data);
      } else if (response.statusCode == 401) {
        final success = await _refreshToken(getRefreshToken()!);
        if (success) {
          headers['Authorization'] = 'Bearer ${getAccessToken()}';
          final retryResponse = await dio.post(
            '${url}users/auth/update',
            data: json.encode(requestData),
            options: Options(headers: headers),
          );
          if (retryResponse.statusCode == 201) {
            final data = retryResponse.data['data'];

            return Data.fromJson(data);
          } else {
            throw Exception('Failed to update user data after token refresh');
          }
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> forgetPass({
    String? phone,
    String? password,
  }) async {
    try {
      final Response response = await dio.post(
        '${url}users/auth/forgot-password',
        data: json.encode({
          'phone': phone,
          'password': password,
        }),
      );
      return response.statusCode;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> removeAccaunt() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final Response response = await dio.post(
        '${url}users/auth/remove',
        options: Options(headers: headers),
      );
      if (response.statusCode == 201) {
        await authBox.clear();
      }

      return response.data['statusCode'];
    } catch (e) {
      rethrow;
    }
  }

  String? getAccessToken() {
    return authBox.get('accessToken');
  }

  String? getRefreshToken() {
    return authBox.get('refresh');
  }

  Future<Data?> getUserProfile() async {
    final headers = {
      'Authorization': 'Bearer ${getAccessToken()}',
      'Cookie': 'i18n_redirected=tk',
    };
    if (getAccessToken() == null) {
      return Data();
    }
    try {
      final Response response = await dio.get(
        '${url}users/auth/profile',
        options: Options(headers: headers),
      );
      log('it is user status code ${response.data['statusCode']}');
      if (response.data['statusCode'] == 200) {
        final Map<String, dynamic> userData = response.data['data'];
        final accessToken = userData['token']?['access'];
        final refreshToken = userData['token']?['refresh'];
        if (accessToken != null && refreshToken != null) {
          await authBox.put('accessToken', accessToken);
          await authBox.put('refreshToken', refreshToken);
        }
        final Data userList = Data.fromJson(userData);
        return userList;
      } else if (response.data['statusCode'] == 401) {
        final success = await _refreshToken(getRefreshToken()!);
        if (success) {
          headers['Authorization'] = 'Bearer ${getAccessToken()}';
          final retryResponse = await dio.get(
            '${url}users/auth/profile',
            options: Options(headers: headers),
          );
          if (retryResponse.data['statusCode'] == 200) {
            final data = retryResponse.data['data'];
            if (data != null) {
              final accessToken = data['token']?['access'];
              final refreshToken = data['token']?['refresh'];
              if (accessToken != null && refreshToken != null) {
                await authBox.put('accessToken', accessToken);
                await authBox.put('refreshToken', refreshToken);
              }
            }
            return Data.fromJson(data);
          } else {
            throw Exception('Failed to get profile after refreshing token');
          }
        } else {
          throw Exception('failed to get user profile');
        }
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Data> subscribeNotification({
    required bool fcmNotifications,
    required bool emailNotifications,
    required bool smsNotifications,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final data = json.encode({
        'fcmNotifications': fcmNotifications,
        'emailNotifications': emailNotifications,
        'smsNotifications': smsNotifications,
      });
      final Response response = await dio.post(
        '${url}users/auth/subscribe-notifications',
        options: Options(headers: headers),
        data: data,
      );
      if (response.data['statusCode'] == 200) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
          }
        }
        return Data.fromJson(data);
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
