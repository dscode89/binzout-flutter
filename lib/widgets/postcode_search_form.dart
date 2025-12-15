import 'package:binzout/widgets/bin_schedule_page.dart';
import 'package:flutter/material.dart';

class PostcodeSearchForm extends StatefulWidget {
  const PostcodeSearchForm({super.key});

  @override
  State<PostcodeSearchForm> createState() => _PostcodeSearchForm();
}

class _PostcodeSearchForm extends State<PostcodeSearchForm> {
  final _inputFormStateKey = GlobalKey<FormState>();
  var providedPostcode = "";

  final TextEditingController _postcodeInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _postcodeInputController.addListener(() {
      final String capitalisedInput = _postcodeInputController.text
          .toUpperCase();
      _postcodeInputController.value = _postcodeInputController.value.copyWith(
        text: capitalisedInput,
      );
    });
  }

  @override
  void dispose() {
    _postcodeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _inputFormStateKey,
        child: Column(
          children: [
            Image.asset('assets/pngwing.com.png', width: 100),
            SizedBox(height: 20),
            TextFormField(
              controller: _postcodeInputController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Postcode required.';
                }
                return null;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Postcode',
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_inputFormStateKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BinSchedulePage(
                        postcode: _postcodeInputController.text,
                      ),
                    ),
                  );
                }
              },

              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(3),
                  ),
                ),
                backgroundColor: WidgetStateProperty<Color>.fromMap(
                  <WidgetStatesConstraint, Color>{
                    WidgetState.hovered: const Color.fromARGB(255, 62, 36, 107),
                    WidgetState.any: Theme.of(context).primaryColor,
                  },
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
