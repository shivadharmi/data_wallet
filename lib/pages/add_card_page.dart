import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/add_card_form.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatelessWidget {
  static const routeName = '/addCard';
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: AddCardForm(),
    );
  }
}
