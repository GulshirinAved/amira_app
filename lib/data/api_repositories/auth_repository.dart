import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();
  Future<int?> signUp({
    String? phone,
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
    String? password,
  }) async {
    return _authProvider.register(
      phone: phone,
      name: name,
      address: address,
      birthday: birthday,
      email: email,
      gender: gender,
      password: password,
    );
  }

  Future<int?> otp({String? phone, int? otp}) async {
    return _authProvider.otp(phone: phone, otp: otp);
  }

  Future<int?> signIn({String? phone, String? password}) async {
    return _authProvider.signIn(phone: phone, password: password);
  }

  Future<Data?> changePass({
    final String? newPassword,
    final String? oldPassword,
  }) async {
    return _authProvider.changePass(
      newPass: newPassword!,
      oldPass: oldPassword!,
    );
  }

  Future<int?> forgetPass({String? phone, String? password}) async {
    return _authProvider.forgetPass(phone: phone, password: password);
  }

  Future<Data?> updateUserData({
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
  }) async {
    return _authProvider.updateUserData(
      name: name,
      address: address,
      birthday: birthday,
      email: email,
      gender: gender,
    );
  }

  Future<int?> removesAccaunt() async {
    return _authProvider.removeAccaunt();
  }

  Future<Data?> getUserProfile() async {
    return _authProvider.getUserProfile();
  }

  Future<Data?> subscribeNotification({
    required bool fcmNotifications,
    required bool emailNotifications,
    required bool smsNotifications,
  }) async {
    return _authProvider.subscribeNotification(
      fcmNotifications: fcmNotifications,
      emailNotifications: emailNotifications,
      smsNotifications: smsNotifications,
    );
  }
}
