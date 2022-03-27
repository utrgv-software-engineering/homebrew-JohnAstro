import 'package:flutter/material.dart';
import 'package:homebrew/screens/choose_cups_screen.dart';
import 'package:homebrew/utils/button_styles.dart';

class ChooseDeviceScreen extends StatefulWidget {
  @override
  _ChooseDeviceScreenState createState() => _ChooseDeviceScreenState();
}

class _ChooseDeviceScreenState extends State<ChooseDeviceScreen> {
  bool _frenchPress = false;
  bool _dripMachine = false;
  bool _continue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'What coffee maker are you using?',
            key: Key('choose-maker-prompt'),
            style: TextStyle(fontSize: 18, color: Color(0xFF4C748B)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 24, 19, 24),
            child: Container(
              width: 337,
              height: 96,
              constraints: BoxConstraints(maxHeight: 96),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFF4C748B)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  // French Press
                  ElevatedButton(
                    key: Key('french-press-button'),
                    onPressed: () {
                      if (_frenchPress) {
                        _frenchPress = !_frenchPress;
                        _continue = !_continue;
                      } else {
                        _frenchPress = !_frenchPress;
                        _dripMachine = false;
                        _continue = true;
                      }
                      setState(() {});
                    },
                    style: buttonStyleType(true), // Top Style
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'French Press',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Icon(Icons.check,
                              color: _frenchPress
                                  ? Color(0xFF4C748B)
                                  : Colors.transparent),
                        ]),
                  ),
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFF4C748B),
                  ),

                  // Drip Machine
                  ElevatedButton(
                    key: Key('drip-machine-button'),
                    onPressed: () {
                      if (_dripMachine) {
                        _dripMachine = !_dripMachine;
                        _continue = !_continue;
                      } else {
                        _dripMachine = !_dripMachine;
                        _frenchPress = false;
                        _continue = true;
                      }
                      setState(() {});
                    },
                    style: buttonStyleType(false), // Bot Style
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Drip Machine',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Icon(Icons.check,
                              color: _dripMachine
                                  ? Color(0xFF4C748B)
                                  : Colors.transparent),
                        ]),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            key: Key('continue-button'),
            onPressed: () {
              setState(() {
                if (_continue) {
                  if (_frenchPress) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cups('french')));
                  } else if (_dripMachine) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cups('drip')));
                  }
                }
              });
            },
            style: continueButtonStyle(_continue),
            child: Text('Continue'),
          ),
        ]),
      ),
    );
  }
}
