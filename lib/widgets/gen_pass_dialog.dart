import 'package:data_wallet/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../utils/hash_key_generator.dart';

class GenPassDialog extends StatefulWidget {
  final Function showSnackBar;
  GenPassDialog(this.showSnackBar);

  @override
  _GenPassDialogState createState() => _GenPassDialogState();
}

class _GenPassDialogState extends State<GenPassDialog> {
  double _hashLength = 8;
  String _hash = hashKeyGenerator(8);

  void test() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: getProportionateScreenWidth(300),
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(getProportionateScreenHeight(10)),
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Unique Password',
              style: TextStyle(
                color: theme.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: getProportionateScreenWidth(0.45 * size.width),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  _hash,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _hash = hashKeyGenerator(_hashLength);
                  });
                },
                icon: Icon(
                  Icons.replay,
                  color: theme.accentColor,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  widget.showSnackBar(_hash);
                },
                icon: Icon(
                  Icons.content_copy,
                  color: theme.accentColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Slider(
            divisions: 8,
            label: 'length: ${_hashLength.toInt()}',
            max: 20,
            min: 4,
            value: _hashLength,
            onChanged: (value) {
              setState(() {
                _hashLength = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
