import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPreferenceValue(String name, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(name, value);
}
