import 'package:data_wallet/models/account.dart';
import 'package:data_wallet/models/card.dart';
import 'package:data_wallet/pages/account_info_page.dart';
import 'package:data_wallet/pages/add_card_page.dart';
import 'package:data_wallet/pages/add_password_page.dart';
import 'package:data_wallet/pages/card_info_page.dart';
import 'package:data_wallet/pages/home_page.dart';
import 'package:data_wallet/pages/introduction_page.dart';
import 'package:data_wallet/providers/accounts.dart';
import 'package:data_wallet/providers/bank_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import './utils/custom_colors.dart';

bool _show;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(CardAdapter());
  final showIntro = await Hive.openBox<bool>('showIntro');
  if (showIntro.values.toList().length == 0) {
    showIntro.add(true);
    _show = Hive.box<bool>('showIntro').values.toList()[0];
  } else {
    _show = Hive.box<bool>('showIntro').values.toList()[0];
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Accounts(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BankCards(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: Locale('en'),
        debugShowCheckedModeBanner: false,
        title: 'Pass Gen',
        theme: ThemeData(
          fontFamily: 'NunitoSans',
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 25,
              color: CustomColors.secondary,
            ),
          ),
          primarySwatch: CustomColors.primary,
          // primaryColor: CustomColors.primary[500],
          accentColor: CustomColors.primary[500],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // SizeConfig.init(context);
        initialRoute: _show ? IntroductionPage.routeName : HomePage.routeName,
        routes: {
          IntroductionPage.routeName: (ctx) => IntroductionPage(),
          HomePage.routeName: (ctx) => HomePage(),
          AddPasswordPage.routeName: (ctx) => AddPasswordPage(),
          AccountInfoPage.routeName: (ctx) => AccountInfoPage(),
          AddCardPage.routeName: (ctx) => AddCardPage(),
          CardInfoPage.routeName: (ctx) => CardInfoPage(),
          LoadingScreen.routeName: (ctx) => LoadingScreen(),
          // RouteDecider.routeName: (ctx) => RouteDecider(),
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  static const routeName = '/loading_screen';

  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
