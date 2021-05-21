import 'package:data_wallet/models/app_intoduction_data.dart';
import 'package:data_wallet/pages/home_page.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/app_intoduction_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IntroductionPage extends StatefulWidget {
  static const routeName = '/intro';

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  int currentIndex = 0;

  List<SlideIndicator> generateSlideIndicators(int currentIndex) {
    return List<SlideIndicator>.generate(
      4,
      (index) {
        if (index == currentIndex) {
          return SlideIndicator(
            color: CustomColors.primary,
            width: getProportionateScreenHeight(40),
          );
        } else {
          return SlideIndicator(
            color: Colors.grey,
            width: getProportionateScreenHeight(20),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Flexible(
                flex: 8,
                child: AppIntroductionTile(
                  appIntroductionTileData:
                      AppIntroductionData().data[currentIndex],
                ),
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(10),
                        horizontal: getProportionateScreenHeight(20),
                      ),
                      child: TextButton(
                        onPressed: currentIndex == 0
                            ? null
                            : () {
                                if (currentIndex > 0 && currentIndex < 4) {
                                  setState(() {
                                    currentIndex -= 1;
                                  });
                                } else {
                                  return;
                                }
                              },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: getProportionateScreenHeight(35),
                        ),
                      ),
                    ),
                    Spacer(),
                    ...generateSlideIndicators(currentIndex),
                    Spacer(),
                    if (currentIndex == 3)
                      TextButton(
                        onPressed: () {
                          Hive.box<bool>('showIntro').put(0, false);
                          Navigator.of(context)
                              .popAndPushNamed(HomePage.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(8),
                            horizontal: getProportionateScreenHeight(16),
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Finish',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.bold,
                              color: CustomColors.secondary,
                            ),
                          ),
                        ),
                      ),
                    if (currentIndex != 3)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10),
                          horizontal: getProportionateScreenHeight(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (currentIndex >= 0 && currentIndex < 3) {
                              setState(() {
                                currentIndex += 1;
                              });
                            } else {
                              return;
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: getProportionateScreenHeight(35),
                          ),
                        ),
                      ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideIndicator extends StatelessWidget {
  final Color color;
  final double width;

  const SlideIndicator({
    Key key,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenHeight(4),
      ),
      height: getProportionateScreenHeight(10),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
    );
  }
}
