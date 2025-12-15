import 'package:binzout/animations/slide_up.dart';
import 'package:binzout/widgets/bin_schedule_page.dart';
import 'package:flutter/material.dart';

class PostcodeSearchForm extends StatefulWidget {
  const PostcodeSearchForm({super.key});

  @override
  State<PostcodeSearchForm> createState() => _PostcodeSearchForm();
}

class _PostcodeSearchForm extends State<PostcodeSearchForm> {
  final _inputFormStateKey = GlobalKey<FormState>();
  bool hasEnteredText = false;

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
              onChanged: (value) {
                if (value.isEmpty) {
                  if (hasEnteredText == true) {
                    setState(() {
                      hasEnteredText = false;
                    });
                  }
                } else {
                  if (hasEnteredText == false) {
                    setState(() {
                      hasEnteredText = true;
                    });
                  }
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Postcode required.';
                }
                return null;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: hasEnteredText
                    ? IconButton(
                        onPressed: () {
                          _postcodeInputController.clear();
                        },
                        tooltip: "Clear",
                        icon: Icon(Icons.dangerous_outlined),
                      )
                    : null,
                border: OutlineInputBorder(),
                labelText: 'Postcode',
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final isValid = _inputFormStateKey.currentState!.validate();
                if (!isValid) return;

                Navigator.of(
                  context,
                ).push(slideUpAnimation(BinSchedulePage(postcode: "L167PQ")));

                _postcodeInputController.clear();
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
