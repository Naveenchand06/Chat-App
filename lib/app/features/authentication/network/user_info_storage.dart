import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class UserInfoStorage {
  // * Saving UserInfo in LocalStorage
  Future<void> saveUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('', true);
  }
}
