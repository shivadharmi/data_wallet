import 'package:flutter/material.dart';

abstract class CustomColors {
  static const MaterialColor primary = MaterialColor(
    0xff1856E3,
    const <int, Color>{
      50: const Color.fromRGBO(116, 154, 238, 1),
      100: const Color.fromRGBO(116, 154, 238, 1),
      200: const Color.fromRGBO(93, 137, 235, 1),
      300: const Color.fromRGBO(70, 120, 233, 1),
      400: const Color.fromRGBO(47, 103, 230, 1),
      500: const Color.fromRGBO(24, 86, 227, 1),
      600: const Color.fromRGBO(22, 77, 204, 1),
      700: const Color.fromRGBO(19, 69, 182, 1),
      800: const Color.fromRGBO(17, 60, 159, 1),
      900: const Color.fromRGBO(14, 52, 136, 1),
    },
  );

  // static const Color primary = Color(0xff1856E3);
  static const Color secondary = Color(0xffffffff);
  static const Color bg = Color(0xffDAE9FF);
// Color.fromRGBO(0, 121, 107, 1)
}
