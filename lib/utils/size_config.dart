import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;
  static EdgeInsets viewPadding;
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    viewPadding = _mediaQueryData.viewPadding;
    defaultSize = screenHeight - viewPadding.top - viewPadding.bottom;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 821.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getOrientationSize(double size) {
  Orientation orientation = SizeConfig.orientation;
  double screenHeight = SizeConfig.screenHeight;
  double screenWidth = SizeConfig.screenWidth;
  if (orientation == Orientation.landscape) {
    return (size / 821.0) * screenHeight;
  } else {
    return (size / 821.0) * screenWidth;
  }
}
