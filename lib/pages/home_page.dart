import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:data_wallet/pages/add_card_page.dart';
import 'package:data_wallet/providers/accounts.dart';
import 'package:data_wallet/providers/bank_cards.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/encryption_utils.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/about.dart';
import 'package:data_wallet/widgets/custom_app_bar.dart';
import 'package:data_wallet/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/add_password_page.dart';
import '../widgets/modal_bottom_sheet_flat_button.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final accounts = Provider.of<Accounts>(
      context,
      listen: false,
    );
    final bankCards = Provider.of<BankCards>(
      context,
      listen: false,
    );
    Future getData() async {
      await accounts.getLocalData();
      await bankCards.getLocalData();
      await setPartOfKey();
      return Future.delayed(
        Duration(
          milliseconds: 600,
        ),
      );
    }

    return FutureBuilder(
      builder: (ctx, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.done) {
          return Home();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: getData(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _showAddModalBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: ctx,
      builder: (newCtx) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
            child: Column(
              children: [
                ModalBottomSheetFlatButton(
                  title: 'Password',
                  icon: Icons.lock,
                  routeName: AddPasswordPage.routeName,
                  id: null,
                ),
                ModalBottomSheetFlatButton(
                  title: 'Card',
                  icon: Icons.credit_card,
                  routeName: AddCardPage.routeName,
                  id: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appBarPrefSize = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: getProportionateScreenHeight(35),
        activeColor: CustomColors.primary,
        backgroundColor: CustomColors.secondary,
        height: getProportionateScreenHeight(60),
        icons: [
          Icons.home_rounded,
          Icons.info_outline_rounded,
        ],
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => currentIndex = index),
        //other params
      ),
      body: currentIndex == 0
          ? SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenHeight(8.0),
                        top: getProportionateScreenHeight(8),
                        right: getProportionateScreenHeight(8),
                      ),
                      child: Column(
                        children: [
                          CustomAppBar(
                            height: appBarPrefSize,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Flexible(
                            child: Tabs(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : About(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddModalBottomSheet(context),
        tooltip: 'Add New Account',
        backgroundColor: CustomColors.primary,
        child: Icon(
          Icons.add,
          size: getProportionateScreenHeight(35),
          color: CustomColors.secondary,
        ),
      ),
    );
  }
}
