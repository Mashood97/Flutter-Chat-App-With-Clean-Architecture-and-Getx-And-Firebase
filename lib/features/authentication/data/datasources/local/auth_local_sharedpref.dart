import 'package:flutter_push_notification_proj/helpers/local_storage_shared_pref/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefAuth {
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPref.init();
    return _prefsInstance;
  }

  static const String _email_key = "key_email";
  static const String _token_key = "key_token";
  static const String _uid_key = "key_uid";

  static Future<bool> saveEmailOfUser(String? userEmail) async {
    bool? isSaved = await _prefsInstance.setString(_email_key, userEmail!);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getEmailOfUser() async {
    String? email = await _prefsInstance.getString(_email_key);
    if (email!.isNotEmpty) {
      return email;
    } else {
      return "";
    }
  }

  static Future<bool> saveTokenOfUser(String? token) async {
    bool? isSaved = await _prefsInstance.setString(_token_key, token!);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getTokenOfUser() async {
    String? token = await _prefsInstance.getString(_token_key);
    if (token!.isNotEmpty) {
      return token;
    } else {
      return "";
    }
  }

  static Future<bool> saveUserId(String? uid) async {
    bool? isSaved = await _prefsInstance.setString(_uid_key, uid!);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserID() async {
    String? uid = await _prefsInstance.getString(_uid_key);
    if (uid!.isNotEmpty) {
      return uid;
    } else {
      return "";
    }
  }

  static Future<void> logoutUser() async {
    _prefsInstance.clear();
  }
}
