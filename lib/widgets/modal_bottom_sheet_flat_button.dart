import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetFlatButton extends StatelessWidget {
  final String id;
  final IconData icon;
  final String title;
  final String routeName;

  ModalBottomSheetFlatButton({
    @required this.title,
    @required this.routeName,
    @required this.icon,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(routeName, arguments: id);
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: getProportionateScreenHeight(20),
            color: CustomColors.primary,
          ),
          SizedBox(
            width: getProportionateScreenWidth(15),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
