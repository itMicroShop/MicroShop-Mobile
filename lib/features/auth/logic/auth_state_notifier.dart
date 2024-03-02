import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/auth/logic/auth_repo.dart';
import 'package:grocerymart/features/auth/model/auth_response.dart';
import 'package:grocerymart/features/auth/model/login_credentials.dart';
import 'package:grocerymart/features/auth/model/sign_up.dart';

class AuthStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  AuthStateNotifier(this.ref) : super(false);

  Future<bool> loginWithEmailAndPassword(
      LoginCredentials loginCredentials) async {
    state = true;
    try {
      final isSuccess = await ref
          .read(authService)
          .loginWithEmailAndPassword(loginCredentials);
      state = false;
      return isSuccess;
    } catch (error) {
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> signUp(SignUpCredential signUpCredential) async {
    state = true;
    try {
      final isSuccess = await ref.read(authService).signUp(signUpCredential);
      state = false;
      return isSuccess;
    } catch (error) {
      return false;
    } finally {
      state = false;
    }
  }

  Future<AuthResponseModel> sendOTP({required String contact}) async {
    state = true;
    try {
      final repoonseModel =
          await ref.read(authService).sendOTP(contact: contact);
      state = false;
      return repoonseModel;
    } catch (error) {
      return AuthResponseModel(isSuccess: false, message: error.toString());
    } finally {
      state = false;
    }
  }

  Future<AuthResponseModel> verifyOTP(
      {required String contact, required String otp}) async {
    state = true;
    try {
      final repoonseModel =
          await ref.read(authService).verifyOTP(contact: contact, otp: otp);
      state = false;
      return repoonseModel;
    } catch (error) {
      return AuthResponseModel(isSuccess: false, message: error.toString());
    } finally {
      state = false;
    }
  }

  Future<AuthResponseModel> changePassword(
      {required String password,
      required String confirmPass,
      required String token}) async {
    state = true;
    try {
      final repoonseModel = await ref.read(authService).changePassword(
            password: password,
            confirmPass: confirmPass,
            token: token,
          );
      state = false;
      return repoonseModel;
    } catch (error) {
      return AuthResponseModel(isSuccess: false, message: error.toString());
    } finally {
      state = false;
    }
  }

  Future<bool> logout() async {
    state = true;
    try {
      final isSuccess = await ref.read(authService).logout();
      state = false;
      return isSuccess;
    } catch (error) {
      return false;
    } finally {
      state = false;
    }
  }
}
