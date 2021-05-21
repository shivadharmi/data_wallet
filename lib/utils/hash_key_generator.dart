import 'dart:math';

String hashKeyGenerator(double length) {
  const String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
  const String _upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const String _numbers = "0123456789";
  const String _special = "@#=+!£\$%&?[](){}";
  const String SpecialString =
      _lowerCaseLetters + _upperCaseLetters + _numbers + _special;
  Iterable<String> passCodeGen() sync* {
    for (var i = 0; i < length; i++) {
      final randomNum = new Random.secure().nextInt(SpecialString.length);
      yield SpecialString[randomNum];
    }
  }

  return [...passCodeGen()].join('');
}
