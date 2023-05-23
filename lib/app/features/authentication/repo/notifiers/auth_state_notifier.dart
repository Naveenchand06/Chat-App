import 'package:chatcord/app/features/authentication/models/auth_result.dart';
import 'package:chatcord/app/features/authentication/network/authenticator.dart';
import 'package:chatcord/app/features/authentication/network/user_info_storage.dart';
import 'package:chatcord/app/utils/storage/storage_strings.dart';
import 'package:chatcord/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatcord/app/features/authentication/models/auth_state.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});

// Auth State Provider (Holds current AuthState)
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((_) {
  return AuthStateNotifier();
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (storage!.getBool(isLoggedIn) ?? false) {
      state = const AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: '',
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
  }

  Future<bool> login(String email, String pass) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.login(email, pass);
    state = AuthState(
      result: result,
      isLoading: false,
      userId: '',
    );

    if (result == AuthResult.success) {
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String pass) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.register(email, pass);
    final userId = '';
    if (result == AuthResult.success && userId.isNotEmpty) {
      // Save user to Users collection
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
    if (result == AuthResult.success) {
      return true;
    }
    return false;
  }

  Future<void> saveUserInfo({required String userId}) =>
      _userInfoStorage.saveUserInfo();
}
