import 'package:data_wallet/providers/accounts.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'custom_text_form_field.dart';
import 'gen_pass_dialog.dart';

class AddPasswordForm extends StatefulWidget {
  @override
  _AddPasswordFormState createState() => _AddPasswordFormState();
}

class _AddPasswordFormState extends State<AddPasswordForm> {
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  final Map<String, String> _formData = {
    'name': '',
    'userName': '',
    'url': '',
    'password': '',
  };
  String _uniPassword;

  var _isLoading = false;

  _saveForm(BuildContext ctx, Accounts accounts) async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      formKey.currentState.save();
      final status = await accounts.addCredentials(_formData, _uniPassword);
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

  void _showSnackBar(String hash) {
    Clipboard.setData(new ClipboardData(text: hash));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied the unique password!"),
      ),
    );
    setState(() {
      _formData['password'] = hash;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = CustomColors.secondary;
    final accounts = Provider.of<Accounts>(context, listen: false);
    final width = MediaQuery.of(context).size.width;

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
                padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        initialValue: _formData['name'],
                        labelText: 'Name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['name'] = value;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: _formData['url'],
                        labelText: 'URL',
                        validator: (value) {
                          // bool _validURL = Uri.parse(value).isAbsolute;
                          if (value.isEmpty) {
                            return 'Please enter valid URL!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['url'] = value;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomTextFormField(
                        initialValue: _formData['userName'],
                        labelText: 'User Name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid username!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['userName'] = value;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Row(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(width * 0.6),
                            child: CustomTextFormField(
                              initialValue: _formData['password'],
                              labelText: 'Password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter valid password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _formData['password'] = value;
                              },
                              isPassword: true,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: getProportionateScreenWidth(width * 0.2),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return GenPassDialog(_showSnackBar);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.replay,
                                    color: theme.accentColor,
                                  ),
                                ),
                                Text('Generate')
                              ],
                            ),
                          )
                        ],
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
                            _saveForm(ctx, accounts);
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
