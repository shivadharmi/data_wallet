import 'package:flutter/foundation.dart';

class AppIntroductionData {
  List<AppIntroductionTileData> _screensData = [
    AppIntroductionTileData(
      imageURL: "assets/images/safe.svg",
      text:
          "Worrying about keeping your data secure? Don't worry we covered you. Everything is safe when it is in our hands. That's why we brought you in-hand digital Data wallet.",
    ),
    AppIntroductionTileData(
      imageURL: "assets/images/privacy.svg",
      text: 'AES 256-bit encryption enabled. Nothing gets out without. ',
    ),
    AppIntroductionTileData(
      imageURL: "assets/images/cards.svg",
      text:
          'Do you usually get butterflies in your stomach during an interview ?Did you fail in an interview even though you were fully qualified ?We present to you some tips that will help you present yourself in a professional manner in any interview - whether campus placement, walk-in or recruitment.',
    ),
    AppIntroductionTileData(
      imageURL: "assets/images/directions.svg",
      text:
          'Do you usually get butterflies in your stomach during an interview ?Did you fail in an interview even though you were fully qualified ?We present to you some tips that will help you present yourself in a professional manner in any interview - whether campus placement, walk-in or recruitment.',
    ),
  ];

  List<AppIntroductionTileData> get data {
    return _screensData;
  }
}

class AppIntroductionTileData {
  final String imageURL;
  final String text;

  AppIntroductionTileData({
    @required this.imageURL,
    @required this.text,
  });
}
