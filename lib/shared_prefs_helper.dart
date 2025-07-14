import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  factory SharedPrefsHelper() => _instance;
  SharedPrefsHelper._internal();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> setLoggedIn(bool value) async {
    final p = await prefs;
    await p.setBool('is_logged_in', value);
  }

  Future<bool> isLoggedIn() async {
    final p = await prefs;
    return p.getBool('is_logged_in') ?? false;
  }

  Future<void> clear() async {
    final p = await prefs;
    await p.clear();
  }
} 