import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Version v1.0.0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenHeight(16),
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '© Copyright 2021 Data Wallet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primary[600],
                    fontSize: getProportionateScreenHeight(16),
                  ),
                ),
                Text(
                  'Developed by Siva Sankar Reddy Bogala',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primary[600],
                    fontSize: getProportionateScreenHeight(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
