// Imports the Flutter Driver API.
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

      // Find prompt, and recommened coffee and water text
      final recommendedPromptFinder = find.byValueKey('recommended-text');
      final coffeeFinder = find.byValueKey('coffee-text');
      final waterFinder = find.byValueKey('water-text');

      // Expect to be in recommended screen
      expect(await driver.getText(recommendedPromptFinder), 'Recommended');

      // Expect recommended coffee and water
      expect(await driver.getText(coffeeFinder), '63g - course ground coffee');
      expect(await driver.getText(waterFinder), '887g - water');
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
    test("should give recommendation for Drip Machine", () {
      //your code here
    });
  });

  group('Sad Paths', () {
    /*
      Given I am on the Coffee Device Selection Screen
      When I press "Continue"
      Then I expect to still be on the Coffee Device Selection Screen
    */
    test("should not advance from Choose Device Screen without a selection",
        () {
      //your code here
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () {
      //your code here
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () {
      //your code here
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "a"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test(
        "should not advance from Choose Cups Screen with letter for cup amount",
        () {
      //your code here
      //if you can restrict the keyboard to numbers only you can delete this test
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () {
      //your code here
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () {
      //your code here
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "a"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test(
        "should not advance from Choose Cups Screen with letter for cup amount",
        () {
      //your code here
      //if you can restrict the keyboard to numbers only you can delete this test
    });
  });

  group('Back Button', () {
    //make up your own tests to check that the back button works
    //on every page
  });
}
