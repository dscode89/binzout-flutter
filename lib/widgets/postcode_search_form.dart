import 'package:flutter/material.dart';

class PostcodeSearchForm extends StatefulWidget {
  const PostcodeSearchForm({super.key});

  @override
  State<PostcodeSearchForm> createState() => _PostcodeSearchForm();
}

class _PostcodeSearchForm extends State<PostcodeSearchForm> {
  final GlobalKey<FormState> _inputFormStateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _inputFormStateKey,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Postcode',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
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
