import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/auth/model/auth_response.dart';
import 'package:grocerymart/features/auth/model/login_credentials.dart';
import 'package:grocerymart/features/auth/model/sign_up.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/service/hive_model.dart';
import 'package:grocerymart/utils/api_client.dart';

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<bool> loginWithEmailAndPassword(
      LoginCredentials loginCredentials) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstant.loginUrl, data: {
      "contact": loginCredentials.email,
      "password": loginCredentials.password,
    });
    if (response.statusCode == 200) {
      final userInfo = User.fromMap(response.data['data']['user']);
      final authToken = response.data['data']['access']['token'];
      ref.read(hiveStorageProvider).saveUserInfo(userInfo: userInfo);
      ref.read(hiveStorageProvider).saveUserAuthToken(authToken: authToken);
      ref.read(apiClientProvider).updateToken(token: authToken);
      return true;
    }
    return false;
  }

  Future<bool> signUp(SignUpCredential signUpCredential) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstant.signUp,
          data: signUpCredential.toMap(),
        );
    if (response.statusCode == 200) {
      final userInfo = User.fromMap(response.data['data']['user']);
      final authToken = response.data['data']['access']['token'];
      ref.read(hiveStorageProvider).saveUserInfo(userInfo: userInfo);
      ref.read(hiveStorageProvider).saveUserAuthToken(authToken: authToken);
      ref.read(apiClientProvider).updateToken(token: authToken);
      return true;
    }
    return false;
  }

  Future<AuthResponseModel> sendOTP({required String contact}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstant.sendOTP, data: {
      'contact': contact,
    });
    final message = response.data['message'];
    if (response.statusCode == 200) {
      return AuthResponseModel(
        isSuccess: true,
        message: message,
        data: response.data['data']['otp'],
      );
    }
    return AuthResponseModel(isSuccess: false, message: message);
  }

  Future<AuthResponseModel> verifyOTP(
      {required String contact, required String otp}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstant.verifyOTP, data: {
      'contact': contact,
      'otp': otp,
    });
    if (response.statusCode == 200) {
      final token = response.data['data']['token'];
      return AuthResponseModel(isSuccess: true, message: token);
    }
    return AuthResponseModel(isSuccess: false, message: '');
  }

  Future<AuthResponseModel> changePassword({
    required String password,
    required String confirmPass,
    required String token,
  }) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstant.changePassword, data: {
      'password': password,
      'password_confirmation': confirmPass,
      'token': token,
    });
    final message = response.data['message'];
    if (response.statusCode == 200) {
      return AuthResponseModel(isSuccess: true, message: message);
    }
    return AuthResponseModel(isSuccess: false, message: message);
  }

  Future<bool> logout() async {
    final response = await ref.read(apiClientProvider).get(AppConstant.signOut);
    if (response.statusCode == 200) return true;
    return false;
  }
}

final authService = Provider((ref) => AuthService(ref));
