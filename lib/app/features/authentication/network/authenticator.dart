import 'package:chatcord/app/features/authentication/models/auth_result.dart';

class Authenticator {
  const Authenticator();

  /// Logout user
  Future<void> logout() async {}

  /// Login
  Future<AuthResult> login(String email, String pass) async {
    try {
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  /// Register
  Future<AuthResult> register(String email, String pass) async {
    try {
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
