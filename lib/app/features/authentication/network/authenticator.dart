import 'package:chatcord/app/features/authentication/models/auth_result.dart';
import 'package:chatcord/app/utils/contants/global.dart';
import 'package:dio/dio.dart';

class Authenticator {
  Authenticator();

  Dio dio = Dio();

  /// Logout user
  Future<void> logout() async {}

  /// Login
  Future<AuthResult> login(String username, String pass) async {
    try {
      await dio.post('$baseUrl/login', data: {});
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  /// Register
  Future<AuthResult> register(String email, String pass) async {
    try {
      await dio.post('$baseUrl/register', data: {});
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
