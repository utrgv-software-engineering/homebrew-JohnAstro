import 'package:flutter/material.dart';
import 'package:homebrew/screens/recommend_coffee_screen.dart';
import 'package:homebrew/utils/button_styles.dart';

class Cups extends StatefulWidget {
  final String maker;
  const Cups(this.maker, {Key key}) : super(key: key);

  @override
  State<Cups> createState() => _CupsState();
}

class _CupsState extends State<Cups> {
  final cupsTextController = TextEditingController();
  String cups;

  bool showError = false;
  String cupsTextFieldErrorMessage = '';
  bool _continue = false;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    cupsTextController.addListener(_checkInput);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    cupsTextController.dispose();
    super.dispose();
  }

  void _checkInput() {
    cups = cupsTextController.text;
    if (cups == '' ||
        cups == '0' ||
        cups.contains(' ') ||
        cups.startsWith(',') ||
        cups.startsWith('.')) {
      cupsTextFieldErrorMessage = 'Invalid';
      showError = true;
      _continue = false;
    } else {
      showError = false;
      _continue = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Number of Cups the user typed in the box
    cups = cupsTextController.text;

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How many cups would you like?',
              style: TextStyle(fontSize: 18, color: Color(0xFF4C748B)),
            ),

            // Text Field
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 24, 19, 34),
              child: Container(
                width: 337,
                height: 48,
                child: TextField(
                  key: Key('cups-textfield'),
                  controller: cupsTextController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 17, color: Color(0xFF4C748B)),
                  decoration: InputDecoration(
                      labelText: 'Enter a number...',
                      labelStyle: TextStyle(color: Color(0xFF4C748B)),
                      errorText: showError ? cupsTextFieldErrorMessage : null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 2.0, color: Color(0xFF4C748B))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2.0, color: Color(0xFF4C748B)))),
                ),
              ),
            ),

            // Continue Button
            Container(
              child: ElevatedButton(
                key: Key('continue-button2'),
                onPressed: () {
                  setState(() {
                    if (_continue) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendCoffee(
                                  widget.maker, int.parse(cups))));
                    }
                  });
                },
                // from button_styles.dart
                style: continueButtonStyle(_continue),
                child: Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
