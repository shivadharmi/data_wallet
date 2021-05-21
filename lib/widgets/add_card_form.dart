import 'package:data_wallet/providers/bank_cards.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import 'custom_text_form_field.dart';

class AddCardForm extends StatefulWidget {
  @override
  _AddCardFormState createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  DateTime selectedDate = DateTime.now();
  final Map<String, String> _formData = {
    'cardNickName': '',
    'cardType': '',
    'nameOnCard': '',
    'cardNumber': '',
    'valid': DateTime.now().toIso8601String(),
    'cvv': '',
  };
  String _uniPassword;

  var _isLoading = false;

  _saveForm(BuildContext ctx, BankCards bankCards) async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      formKey.currentState.save();
      _formData['cardNickName'] = _formData['cardNickName'] +
          '-' +
          _formData['cardNumber'].toString().substring(12, 16);
      final status = await bankCards.addCard(_formData, _uniPassword);
      setState(() {
        _isLoading = false;
      });
      if (status) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text("couldn't save data. Try Again!"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = CustomColors.secondary;
    final bankCards = Provider.of<BankCards>(context, listen: false);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(15),
                vertical: getProportionateScreenHeight(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        initialValue: _formData['cardNickName'],
                        labelText: 'Card Nick Name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['cardNickName'] = value;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: _formData['nameOnCard'],
                        labelText: 'Name On Card',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['nameOnCard'] = value;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: _formData['cardNumber'],
                        labelText: 'Card Number',
                        validator: (value) {
                          if (value.isEmpty || value.toString().length != 16) {
                            return 'Please enter valid card number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['cardNumber'] = value;
                        },
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(8.0)),
                        child: Row(
                          children: [
                            Text(
                              '${selectedDate.month}/${selectedDate.year.toString().substring(2, 4)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(25),
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              child: Text(
                                'Select Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(16),
                                  color: secondaryColor,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    theme.primaryColor),
                              ),
                              onPressed: () {
                                showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year,
                                      DateTime.now().month + 1),
                                  lastDate: DateTime(2030, 1),
                                  initialDate: DateTime.now(),
                                  locale: Locale('en'),
                                ).then((date) {
                                  if (date != null) {
                                    print(date);
                                    setState(() {
                                      selectedDate = date;
                                      _formData['valid'] =
                                          selectedDate.toString();
                                      print(_formData['valid']);
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: _formData['cvv'],
                        labelText: 'CVV',
                        validator: (value) {
                          if (value.isEmpty || value.toString().length != 3) {
                            return 'Please enter valid cvv number!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['cvv'] = value;
                        },
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: "",
                        labelText: 'Universal Password',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter universal password text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _uniPassword = value;
                        },
                        isPassword: true,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Builder(builder: (ctx) {
                        return ElevatedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(16),
                              color: secondaryColor,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(theme.primaryColor),
                          ),
                          onPressed: () {
                            _saveForm(ctx, bankCards);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
