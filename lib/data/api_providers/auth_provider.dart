import 'dart:convert';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:dio/dio.dart';

import 'package:hive/hive.dart';

class AuthProvider {
  Dio dio = Dio();
  final Box authBox = Hive.box('auth');
  final Box userBox = Hive.box('userBox');

  Future<int?> register({
    String? phone,
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
    String? password,
  }) async {
    try {
      final Response response = await dio.post(
        '${url}users/auth/sign-up',
        data: json.encode(
          {
            'phone': phone,
            'name': name,
            'address': address,
            'birthday': birthday,
            'email': email,
            'gender': gender,
            'password': password,
          },
        ),
      );

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
          await userBox.put('userData', data);
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
      if (response.statusCode == 201) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
          }

          await userBox.put('userData', data);
        }
      }

      return response.data['statusCode'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> changePass({
    required String oldPassword,
    required String newPassword,
  }) async {
    final headers = {
      'Authorization': 'Bearer ${getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };

    try {
      final Response response = await dio.post(
        '${url}users/auth/change-password',
        options: Options(headers: headers),
        data: json.encode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];

          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
            await userBox.put('userData', data);
          }
        }
        return response.data['statusCode'];
      } else {
        throw Exception('Failed to change password: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
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
        'name': name,
        'address': 'upd-address',
        'birthday': birthday ?? '1991-10-10',
        'email': email == '' ? null : email,
        'gender': gender ?? 'male',
      };

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
      print('API response status: ${response.statusCode}');
      print('API response data: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data['data'];
        if (data == null || data is! Map) {
          throw Exception('Invalid data format received from API');
        }
        await userBox.put('userData', data);
        print('Data stored in userBox: ${userBox.get('userData')}');

        return Data.fromJson(data);
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
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
        await userBox.clear();
      }

      return response.data['statusCode'];
    } catch (e) {
      throw e;
    }
  }

  String? getAccessToken() {
    return authBox.get('accessToken');
  }

  String? getRefreshToken() {
    return authBox.get('refresh');
  }

  Data? getUserData() {
    final userData = userBox.get('userData');
    if (userData != null && userData is Map) {
      final data = Data.fromJson(userData);
      return data;
    }
    return null;
  }
}
