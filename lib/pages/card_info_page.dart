import 'package:data_wallet/providers/bank_cards.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/encryption_utils.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/account_info_password_field.dart';

class CardInfoPage extends StatefulWidget {
  static const routeName = '/card_info';

  @override
  _CardInfoPageState createState() => _CardInfoPageState();
}

class _CardInfoPageState extends State<CardInfoPage> {
  bool _showPassword = false;
  TextEditingController _controller = TextEditingController();
  String _decryptedCardNumber;
  String _decryptedValid;
  String _decryptedCVV;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime valid;
    if (_showPassword) {
      valid = DateTime.parse(_decryptedValid);
    }
    final id = ModalRoute.of(context).settings.arguments;
    final bankCards = Provider.of<BankCards>(context);
    final card = bankCards.getCardById(id);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Card Info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(20),
            color: CustomColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: CustomColors.secondary,
            ),
            onPressed: () {
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
                    _decryptedCardNumber = decryptData(card.cardNumber, value);
                    _decryptedValid = decryptData(card.valid, value);
                    _decryptedCVV = decryptData(card.cvv, value);
                    _showPassword = !_showPassword;
                    _controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Decrypted the card details successfully."),
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountInfoField(
              field: "Card Nick Name",
              value: card.cardNickName.split('-')[0].toUpperCase(),
            ),
            AccountInfoField(
              field: "Card Number",
              value: _showPassword
                  ? _decryptedCardNumber
                  : 'XXXXXXXXXXXX' + card.cardNickName.split('-')[1],
              wrap: true,
            ),
            AccountInfoField(
              field: "valid",
              value: _showPassword
                  ? '${valid.month}/${valid.year.toString().substring(2, 4)}'
                  : 'XXXX',
              wrap: true,
            ),
            AccountInfoField(
              field: "CVV",
              value: _showPassword ? _decryptedCVV : 'XXX',
            ),
            AccountInfoField(
              field: "Name On Card",
              value: card.nameOnCard,
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
            width: getProportionateScreenHeight(120),
            padding: EdgeInsets.all(getProportionateScreenHeight(6)),
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
                  fontSize: getProportionateScreenHeight(15),
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (field != "Card Nick Name")
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
