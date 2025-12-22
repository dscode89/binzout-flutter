import 'package:shared_preferences/shared_preferences.dart';

Future<String> getCurrentPostcode() async {
  final prefs = await SharedPreferences.getInstance();
  final currentPage = prefs.getString("postcode");

  if (currentPage == null) {
    return '/';
  } else {
    return currentPage;
  }
}
