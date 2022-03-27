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
    // Calculate water in grams given cups
    int ounces = CoffeeTools.cupsToOunces(cups);
    double water = CoffeeTools.ouncesToGrams(ounces);

    // Round the double for UI and int for coffee grams calculation
    int roundedWater = water.round();
    int coffeeGrams;

    // Check the type of coffee maker and return map with calculations
    if (maker == 'french') {
      coffeeGrams = CoffeeTools.frenchPress(water).round();
      Map<String, Object> rec = {'Coffee': coffeeGrams, 'Water': roundedWater};
      return rec;
    } else if (maker == 'drip') {
      coffeeGrams = CoffeeTools.dripMachine(water).round();
      Map<String, Object> rec = {'Coffee': coffeeGrams, 'Water': roundedWater};
      return rec;
    }
  }

  // Input: Coffee maker type
  // Output: Coffee type
  _getCoffeeType(String maker) {
    if (maker == 'french') {
      return 'course';
    } else if (maker == 'drip') {
      return 'medium';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get Recommendations
    Map<String, Object> recommendations =
        _getRecommendation(widget.cups, widget.maker);

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        leading: IconButton(
            key: Key('back-button2'),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Color(0xFFF3F3F3),
        foregroundColor: Color(0xFF4C748B),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 170, 19, 170),
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
                        key: Key('recommended-text'),
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
                        '${recommendations['Coffee']}g - ${_getCoffeeType(widget.maker)} ground coffee',
                        key: Key('coffee-text'),
                        style: TextStyle(
                            fontFamily: 'Kollekif', color: Color(0xFF4C748B)),
                      ),
                    ),
                    Text(
                      '${recommendations['Water']}g - water',
                      key: Key('water-text'),
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
                key: Key('done-button'),
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
