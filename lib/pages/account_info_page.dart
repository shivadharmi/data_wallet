import 'package:data_wallet/providers/accounts.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../widgets/account_info_password_field.dart';

class AccountInfoPage extends StatefulWidget {
  static const routeName = '/account_info';

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final id = ModalRoute.of(context).settings.arguments;
    final accounts = Provider.of<Accounts>(context);
    final account = accounts.getAccountById(id);
    final themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Account Info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(20),
            color: CustomColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 10,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.1,
                    cornerStyle: CornerStyle.bothCurve,
                    color: CustomColors.bg,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: account.safetyScore,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: account.safetyScore.toInt() < 5
                          ? Colors.red
                          : account.safetyScore.toInt() >= 5 &&
                                  account.safetyScore.toInt() <= 8
                              ? Colors.amber
                              : Colors.green,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${account.safetyScore.toInt()} / 10',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(35),
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primary,
                            ),
                          ),
                          Text(
                            'Safety Score',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AccountInfoField(
              field: "Account Type",
              value: account.name.toUpperCase(),
            ),
            AccountInfoField(
              field: "User Name",
              value: account.userName,
              wrap: true,
            ),
            AccountInfoPasswordField(
              account: account,
              themeData: themeData,
            ),
            AccountInfoField(
              field: "URL",
              value: account.url,
            ),
          ],
        ),
      ),
    );
  }
}

class AccountInfoField extends StatelessWidget {
  final String field;
  final String value;
  final bool wrap;

  AccountInfoField({
    this.field,
    this.value,
    this.wrap,
  });

  void _showSnackBar(BuildContext context, String hash, String type) {
    Clipboard.setData(new ClipboardData(text: hash));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied the $type "),
      ),
    );
  }

  final border = Border(
    top: BorderSide(width: 2.0, color: CustomColors.bg),
    left: BorderSide(width: 2.0, color: CustomColors.bg),
    right: BorderSide(width: 2.0, color: CustomColors.bg),
    bottom: BorderSide(width: 2.0, color: CustomColors.bg),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(border: border),
            child: Text(
              "$field: ",
              style: TextStyle(
                // color: CustomColors.primary,
                fontSize: getProportionateScreenHeight(15),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(6)),
              decoration: BoxDecoration(border: border),
              child: Text(
                value,
                softWrap: true,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (field != "Account Type")
            Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              decoration: BoxDecoration(border: border),
              child: GestureDetector(
                onTap: () {
                  _showSnackBar(context, value, field);
                },
                child: Icon(
                  Icons.content_copy,
                  color: CustomColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
