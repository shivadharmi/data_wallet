import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double height;

  CustomAppBar({
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        getProportionateScreenHeight(20),
      ),
      child: Row(
        children: [
          // SvgPicture.asset(
          //   'assets/images/password.svg',
          //   height: 64,
          //   width: 64,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(3),
                width: getProportionateScreenWidth(25),
                color: CustomColors.primary,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Container(
                height: getProportionateScreenHeight(3),
                width: getProportionateScreenWidth(18),
                color: CustomColors.primary,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Container(
                height: getProportionateScreenHeight(3),
                width: getProportionateScreenWidth(25),
                color: CustomColors.primary,
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.search_rounded,
            color: CustomColors.primary,
            size: getProportionateScreenHeight(35),
          ),
        ],
      ),
    );
  }
}
