import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/cards.dart';
import 'package:data_wallet/widgets/category_tab.dart';
import 'package:data_wallet/widgets/passwords.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentTab = 0;

  void handleTabs(int tab) {
    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => handleTabs(0),
                child: CategoryTab(
                  activeIconURL: 'assets/images/password_active.svg',
                  iconURL: 'assets/images/password.svg',
                  isActive: currentTab == 0,
                  title: 'Passwords',
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () => handleTabs(1),
                child: CategoryTab(
                  isActive: currentTab == 1,
                  activeIconURL: 'assets/images/credit-card_active.svg',
                  iconURL: 'assets/images/credit-card.svg',
                  title: 'Payment Cards',
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () => handleTabs(2),
                child: CategoryTab(
                  title: 'Addresses',
                  isActive: currentTab == 2,
                  iconURL: 'assets/images/address.svg',
                  activeIconURL: 'assets/images/address_active.svg',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        if (currentTab == 0)
          Expanded(
            child: Passwords(),
          ),
        if (currentTab == 1)
          Expanded(
            child: Cards(),
          ),
        if (currentTab == 2)
          Expanded(
            child: Center(
              child: Text(
                'Addresses - Coming Soon!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
