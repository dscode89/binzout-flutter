import 'package:flutter/material.dart';

class PostcodeSearchForm extends StatefulWidget {
  const PostcodeSearchForm({super.key});

  @override
  State<PostcodeSearchForm> createState() => _PostcodeSearchForm();
}

class _PostcodeSearchForm extends State<PostcodeSearchForm> {
  final _inputFormStateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _inputFormStateKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Postcode required.';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Postcode',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _inputFormStateKey.currentState!.validate();
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
