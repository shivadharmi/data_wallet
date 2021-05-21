import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final Function onSaved;
  final String initialValue;
  final bool isPassword;
  final TextInputType inputType;

  CustomTextFormField({
    @required this.labelText,
    @required this.validator,
    @required this.onSaved,
    @required this.initialValue,
    this.isPassword = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(56),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: isPassword,
        initialValue: initialValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
