import 'package:data_wallet/models/account.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/encryption_utils.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfoPasswordField extends StatefulWidget {
  final Account account;
  final ThemeData themeData;

  AccountInfoPasswordField({
    this.account,
    this.themeData,
  });

  @override
  _AccountInfoPasswordFieldState createState() =>
      _AccountInfoPasswordFieldState();
}

class _AccountInfoPasswordFieldState extends State<AccountInfoPasswordField> {
  bool _showPassword = false;
  TextEditingController _controller = TextEditingController();
  String _decryptedPassword;

  void _showSnackBar(String hash) {
    Clipboard.setData(new ClipboardData(text: hash));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied the password!"),
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
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            decoration: BoxDecoration(border: border),
            width: getProportionateScreenHeight(120),
            child: Text(
              "Password: ",
              style: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.bold,
                // color: CustomColors.primary,
              ),
            ),
          ),
          if (_showPassword)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                decoration: BoxDecoration(border: border),
                child: Text(
                  _decryptedPassword,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (_showPassword == false)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                decoration: BoxDecoration(border: border),
                child: Text(
                  "***************",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (_showPassword)
            Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(6)),
              decoration: BoxDecoration(border: border),
              child: GestureDetector(
                onTap: () {
                  _showSnackBar(_decryptedPassword);
                },
                child: Icon(
                  Icons.content_copy,
                  color: theme.accentColor,
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(6)),
            decoration: BoxDecoration(border: border),
            child: GestureDetector(
              child: Icon(
                Icons.remove_red_eye,
                color: widget.themeData.primaryColor,
              ),
              onTap: () async {
                if (_showPassword == true) {
                  setState(() {
                    _showPassword = false;
                  });
                  return;
                }
                showPasswordInputDialog(context, _controller)
                    .then((String value) {
                  if (value == null || value.isEmpty) {
                    return;
                  }
                  try {
                    setState(() {
                      _decryptedPassword =
                          decryptData(widget.account.password, value);
                      _showPassword = !_showPassword;
                      _controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Decrypted the password successfully."),
                        ),
                      );
                    });
                  } catch (e) {
                    _controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to decrypt the password."),
                      ),
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<String> showPasswordInputDialog(
    BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: Text(
          "Universal Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(15),
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          SizedBox(
            width: getProportionateScreenHeight(10),
            child: TextField(
              controller: controller,
              autofocus: true,
              obscureText: true,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.value.text);
            },
            child: Container(
              width: double.infinity,
              color: CustomColors.primary,
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(8),
                horizontal: getProportionateScreenHeight(16),
              ),
              child: Text(
                "submit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  color: CustomColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        contentPadding: EdgeInsets.all(getProportionateScreenHeight(10)),
      );
    },
  );
}
