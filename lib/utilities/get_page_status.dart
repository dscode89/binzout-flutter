import 'package:binzout/main.dart';
import 'package:binzout/widgets/bin_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> getPageStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final currentPostcode = prefs.getString("postcode");

  if (currentPostcode == null) {
    return MyHomePage(title: 'Binzout!');
  } else {
    return BinSchedulePage();
  }
}
