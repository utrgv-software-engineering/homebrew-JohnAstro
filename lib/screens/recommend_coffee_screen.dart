import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homebrew/utils/coffee_tools.dart';
import 'package:homebrew/utils/button_styles.dart';
import 'package:homebrew/screens/choose_device_screen.dart';

class RecommendCoffee extends StatefulWidget {
  String maker;
  int cups;
  RecommendCoffee(this.maker, this.cups, {Key key}) : super(key: key);

  @override
  State<RecommendCoffee> createState() => _RecommendCoffeeState();
}

class _RecommendCoffeeState extends State<RecommendCoffee> {
  // Input: cups of coffee and coffee maker
  // Output: rounded grams of coffee and water needed
  _getRecommendation(int cups, String maker) {
    int ounces = CoffeeTools.cupsToOunces(cups);
    double water = CoffeeTools.ouncesToGrams(ounces);
    int roundedWater = water.round();

    // Check the type of coffee maker and return map with calculations
    if (maker == 'french') {
      int coffeeGrams = CoffeeTools.frenchPress(water).round();
      Map<String, Object> rec = {'Coffee': coffeeGrams, 'Water': roundedWater};
      return rec;
    } else if (maker == 'drip') {
      int coffeeGrams = CoffeeTools.dripMachine(water).round();
      Map<String, Object> rec = {'Coffee': coffeeGrams, 'Water': roundedWater};
      return rec;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _continue = true;
    Map<String, Object> recommendations =
        _getRecommendation(widget.cups, widget.maker);

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 252, 19, 170),
              child: Container(
                width: 337,
                height: 164,
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Color(0xFF4C748B)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(101, 12, 101, 0),
                      child: Text(
                        'Recommended',
                        key: Key('Recommended-text'),
                        style: TextStyle(
                            fontFamily: 'Kollektif',
                            fontSize: 18,
                            color: Color(0xFF4C748B)),
                      ),
                    ),
                    Container(
                      width: 293,
                      child: Divider(
                        thickness: 1.0,
                        color: Color(0xFF4C748B),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: Text(
                        '${recommendations['Coffee']}g - course ground coffee',
                        style: TextStyle(
                            fontFamily: 'Kollekif', color: Color(0xFF4C748B)),
                      ),
                    ),
                    Text(
                      '${recommendations['Water']}g - water',
                      style: TextStyle(
                          fontFamily: 'Kollekif', color: Color(0xFF4C748B)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        'Enjoy your delicious coffee',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Color(0xFF4C748B)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
                key: Key('Done-button'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseDeviceScreen()));
                },
                // From utils/button_styles.dart
                style: doneButtonStyle(),
                child: Text('Done'))
          ],
        ),
      ),
    );
  }
}
