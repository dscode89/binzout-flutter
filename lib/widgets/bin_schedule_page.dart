import 'package:flutter/material.dart';

class BinSchedulePage extends StatelessWidget {
  final String postcode;

  const BinSchedulePage({super.key, required this.postcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Center(child: Text('data')),
      ),
    );
  }
}
