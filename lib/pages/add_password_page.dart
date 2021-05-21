import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/add_password_form.dart';
import 'package:flutter/material.dart';

class AddPasswordPage extends StatelessWidget {
  static const routeName = '/addPassword';
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
      ),
      body: AddPasswordForm(),
    );
  }
}
