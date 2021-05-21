import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryTab extends StatelessWidget {
  final bool isActive;
  final String activeIconURL;
  final String iconURL;
  final String title;

  const CategoryTab({
    Key key,
    @required this.isActive,
    @required this.activeIconURL,
    @required this.iconURL,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(180),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(
              1.0,
              1.0,
            ),
            color: Colors.grey[300],
            blurRadius: 10.0,
          ),
          BoxShadow(
            offset: const Offset(
              -1.0,
              -1.0,
            ),
            color: Colors.grey[300],
            blurRadius: 10.0,
          ),
        ],
        color: isActive ? CustomColors.primary : CustomColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Spacer(),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
              child: SvgPicture.asset(
                isActive ? activeIconURL : iconURL,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Flexible(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(15),
                color: isActive ? CustomColors.secondary : CustomColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
