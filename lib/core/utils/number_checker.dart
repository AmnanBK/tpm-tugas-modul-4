class NumberChecker {

  static bool isEven(int number) {
    return number % 2 == 0;
  }

  static bool isOdd(int number) {
    return number % 2 != 0;
  }

  static bool isPrime(int number) {
    if (number <= 1) return false;

    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }

    return true;
  }

}