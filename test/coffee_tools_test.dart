import 'package:homebrew/utils/coffee_tools.dart';
import 'package:test/test.dart';

void main() {
  group("cupsToOunces", () {
    test('calculates ounces on 1 cup', () {
      var ounces = CoffeeTools.cupsToOunces(1);
      expect(ounces, 6);
    });

    test('calculates ounces on positive number of cups', () {
      var ounces = CoffeeTools.cupsToOunces(4);
      expect(ounces, 24);
    });

    test('throws ArgumentError on zero', () {
      expect(() => CoffeeTools.cupsToOunces(0), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CoffeeTools.cupsToOunces(-1), throwsArgumentError);
    });
  });

  group("ouncesToGrams", () {
    test('calculates grams in 1 cup', () {
      var ounces = CoffeeTools.cupsToOunces(1);
      var waterGrams = CoffeeTools.ouncesToGrams(ounces);

      expect(waterGrams, 177.42);
    });

    test('throws ArgumentError on zero', () {
      expect(() => CoffeeTools.ouncesToGrams(0), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CoffeeTools.ouncesToGrams(-1), throwsArgumentError);
    });
  });

  group("frenchPress", () {
    test('calculates grams of coffee', () {
      var ounces = CoffeeTools.cupsToOunces(1);
      var waterGrams = CoffeeTools.ouncesToGrams(ounces);
      var coffeeGrams = CoffeeTools.frenchPress(waterGrams);

      expect(coffeeGrams, 12.67);
    });

    test('throws ArgumentError on zero', () {
      expect(() => CoffeeTools.frenchPress(0), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CoffeeTools.frenchPress(-1), throwsArgumentError);
    });
  });

  group("dripMachine", () {
    test('calculates grams of coffee', () {
      var ounces = CoffeeTools.cupsToOunces(1);
      var waterGrams = CoffeeTools.ouncesToGrams(ounces);
      var coffeeGrams = CoffeeTools.dripMachine(waterGrams);

      expect(coffeeGrams, 10.44);
    });

    test('throws ArgumentError on zero', () {
      expect(() => CoffeeTools.dripMachine(0), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CoffeeTools.dripMachine(-1), throwsArgumentError);
    });
  });
}
