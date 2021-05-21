import 'package:data_wallet/models/app_intoduction_data.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIntroductionTile extends StatelessWidget {
  final AppIntroductionTileData appIntroductionTileData;
  AppIntroductionTile({
    Key key,
    @required this.appIntroductionTileData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 4,
          child: SvgPicture.asset(
            appIntroductionTileData.imageURL,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
            child: Text(
              appIntroductionTileData.text,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
