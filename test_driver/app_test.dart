// Imports the Flutter Driver API.
import 'dart:io';
import 'dart:math';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Happy Paths', () {
    /*
      Given I am on the Coffee Device Selection Screen
      When I tap "French Press"
      And I tap "Continue"
      And I enter "5"
      And I tap "Continue"
      Then I should see "63g - course ground coffee"
      And I should see "887g - water"
    */
    test("should give recommendation for French Press", () async {
      // Find french press button, continue button and screen text
      final frenchPressBtnFinder = find.byValueKey('french-press-button');
      final continueBtnFinder = find.byValueKey('continue-button');
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');

      // Expect choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap french press button and continue
      await driver.tap(frenchPressBtnFinder);
      await driver.tap(continueBtnFinder);

      // Find prompt, text field, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter 5 before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('5');
      await driver.tap(continueBtnFinder2);

      // Find prompt, recommened coffee and water text, and done button
      final recommendedPromptFinder = find.byValueKey('recommended-text');
      final coffeeFinder = find.byValueKey('coffee-text');
      final waterFinder = find.byValueKey('water-text');
      final doneButtonFinder = find.byValueKey('done-button');

      // Expect to be in recommended screen
      expect(await driver.getText(recommendedPromptFinder), 'Recommended');

      // Expect recommended coffee and water
      expect(await driver.getText(coffeeFinder), '63g - course ground coffee');
      expect(await driver.getText(waterFinder), '887g - water');

      // Tap done and go back to the Device Selection Screen
      await driver.tap(doneButtonFinder);
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');
    });

    /*
      Given I am on the Coffee Device Selection Screen
      When I tap "Drip Machine"
      And I tap "Continue"
      And I enter "5"
      And I tap "Continue"
      Then I should see "52g - medium ground coffee"
      And I should see "887g - water"
    */
    test("should give recommendation for Drip Machine", () async {
      // Find Drip Machine button, continue button and screen text
      final frenchPressBtnFinder = find.byValueKey('drip-machine-button');
      final continueBtnFinder = find.byValueKey('continue-button');
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');

      // Expect choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap french press button and continue
      await driver.tap(frenchPressBtnFinder);
      await driver.tap(continueBtnFinder);

      // Find prompt, text field, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter 5 before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('5');
      await driver.tap(continueBtnFinder2);

      // Find prompt, recommened coffee and water text, and done button
      final recommendedPromptFinder = find.byValueKey('recommended-text');
      final coffeeFinder = find.byValueKey('coffee-text');
      final waterFinder = find.byValueKey('water-text');
      final doneButtonFinder = find.byValueKey('done-button');

      // Expect to be in recommended screen
      expect(await driver.getText(recommendedPromptFinder), 'Recommended');

      // Expect recommended coffee and water
      expect(await driver.getText(coffeeFinder), '52g - medium ground coffee');
      expect(await driver.getText(waterFinder), '887g - water');

      // Tap done and go back to the Device Selection Screen
      await driver.tap(doneButtonFinder);
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');
    });
  });

  group('Sad Paths', () {
    /*
      Given I am on the Coffee Device Selection Screen
      When I press "Continue"
      Then I expect to still be on the Coffee Device Selection Screen
    */
    test("should not advance from Choose Device Screen without a selection",
        () async {
      // Find screen text and continue button
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap on continue button and expect to be in the coffee device selection screen
      driver.tap(continueButtonFinder);
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () async {
      // Find screen text, French Press button, and continue button
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final frenchPressButtonFinder = find.byValueKey('french-press-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(frenchPressButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen and continue button 2
      final chooseCupsScreenFinder = find.byValueKey('enter-cups-text');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      expect(await driver.getText(chooseCupsScreenFinder),
          'How many cups would you like?');
      driver.tap(continueBtnFinder2);

      // Go back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect French Press Button
      driver.tap(frenchPressButtonFinder);
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      // Find Coffee Device Selection Screen text, french press and continue buttons
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final frenchPressButtonFinder = find.byValueKey('french-press-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(frenchPressButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen, textfield, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter 5 before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('-1');
      await driver.tap(continueBtnFinder2);

      // Expect to be in the same screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Navigate back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect French Press Button
      driver.tap(frenchPressButtonFinder);
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "0"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with 0 for cup amount",
        () async {
      // Find Coffee Device Selection Screen text, french press and continue buttons
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final frenchPressButtonFinder = find.byValueKey('french-press-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(frenchPressButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen, textfield, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter empty string before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('0');
      await driver.tap(continueBtnFinder2);

      // Expect to be in the same screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Navigate back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect French Press Button
      driver.tap(frenchPressButtonFinder);
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () async {
      // Find screen text, Drip Machine button, and continue button
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final dripMachineButtonFinder = find.byValueKey('drip-machine-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(dripMachineButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen and continue button 2
      final chooseCupsScreenFinder = find.byValueKey('enter-cups-text');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      expect(await driver.getText(chooseCupsScreenFinder),
          'How many cups would you like?');
      driver.tap(continueBtnFinder2);

      // Go back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect Drip Machine Button
      driver.tap(dripMachineButtonFinder);
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      // Find screen text, Drip Machine button, and continue button
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final dripMachineButtonFinder = find.byValueKey('drip-machine-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(dripMachineButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen, textfield, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter empty string before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('-1');
      await driver.tap(continueBtnFinder2);

      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');
      driver.tap(continueBtnFinder2);

      // Go back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect Drip Machine Button
      driver.tap(dripMachineButtonFinder);
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "0"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with 0 for cup amount",
        () async {
      // Find screen text, Drip Machine button, and continue button
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');
      final dripMachineButtonFinder = find.byValueKey('drip-machine-button');
      final continueButtonFinder = find.byValueKey('continue-button');

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap French Press and continue
      driver.tap(dripMachineButtonFinder);
      driver.tap(continueButtonFinder);

      // Find Choose Cups Screen, textfield, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter empty string before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('0');
      await driver.tap(continueBtnFinder2);

      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');
      driver.tap(continueBtnFinder2);

      // Go back
      final backButtonFinder = find.byValueKey('back-button');
      driver.tap(backButtonFinder);

      // Expect to be in choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Deselect Drip Machine Button
      driver.tap(dripMachineButtonFinder);
    });
  });

  group('Back Button', () {
    test(
        "should navigate from Recommended Coffee Screen to Choose Device Screen",
        () async {
      // Find Drip Machine button, continue button and screen text
      final frenchPressBtnFinder = find.byValueKey('drip-machine-button');
      final continueBtnFinder = find.byValueKey('continue-button');
      final chooseMakerPromptFinder = find.byValueKey('choose-maker-prompt');

      // Expect choose device screen
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');

      // Tap french press button and continue
      await driver.tap(frenchPressBtnFinder);
      await driver.tap(continueBtnFinder);

      // Find prompt, text field, and continue button
      final enterCupsPromptFinder = find.byValueKey('enter-cups-text');
      final cupsTextfieldFinder = find.byValueKey('cups-textfield');
      final continueBtnFinder2 = find.byValueKey('continue-button2');

      // Expect choose cups screen
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Tap text field and enter 5 before continue
      await driver.tap(cupsTextfieldFinder);
      await driver.enterText('5');
      await driver.tap(continueBtnFinder2);

      // Find prompt, recommened coffee and water text, and done button
      final recommendedPromptFinder = find.byValueKey('recommended-text');
      final coffeeFinder = find.byValueKey('coffee-text');
      final waterFinder = find.byValueKey('water-text');
      final doneButtonFinder = find.byValueKey('done-button');

      // Expect to be in recommended screen
      expect(await driver.getText(recommendedPromptFinder), 'Recommended');

      // Expect recommended coffee and water
      expect(await driver.getText(coffeeFinder), '52g - medium ground coffee');
      expect(await driver.getText(waterFinder), '887g - water');

      // Find back buttons
      final backButtonFinder = find.byValueKey('back-button');
      final backButtonFinder2 = find.byValueKey('back-button2');

      // Navigate back and expect choose cups screen
      driver.tap(backButtonFinder2);
      expect(await driver.getText(enterCupsPromptFinder),
          'How many cups would you like?');

      // Navigate back and expect choose devise screen
      driver.tap(backButtonFinder);
      expect(await driver.getText(chooseMakerPromptFinder),
          'What coffee maker are you using?');
    });
  });
}
