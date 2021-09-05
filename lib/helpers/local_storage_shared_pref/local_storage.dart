import 'package:shared_preferences/shared_preferences.dart';

//Singleton class for Local Storage Using Shared Preferences
class SharedPref {
  //initialization of Singleton Shared prefernces.
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefs;
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }
}
