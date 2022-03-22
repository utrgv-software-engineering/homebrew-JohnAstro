// Extension on the double
extension ExtendedDouble on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class CoffeeTools {
  // Input: number of cups (positive integer)
  // Output: number of ounces in a cup
  static int cupsToOunces(int cups) {
    if (cups <= 0) {
      throw ArgumentError();
    }
    return cups * 6;
  }

  // Input: number of ounces (positive integer)
  // Output: number of grams in ounces
  static double ouncesToGrams(int ounces) {
    if (ounces <= 0) {
      throw ArgumentError();
    }
    // Using extension ExtendedDouble
    return (ounces * 29.57).toPrecision(2);
  }

  // Input: number of grams of water (positive integer)
  // Output: number of grams of coffee
  static double frenchPress(double water) {
    if (water <= 0) {
      throw ArgumentError();
    }
    // Using extension ExtendedDouble
    return (water / 14).toPrecision(2);
  }

  // Input: number of grams of water (positive integer)
  // Output: number of grams of coffee
  static double dripMachine(double water) {
    if (water <= 0) {
      throw ArgumentError();
    }
    // Using extension ExtendedDouble
    return (water / 17).toPrecision(2);
  }
}
