import 'package:data_wallet/pages/account_info_page.dart';
import 'package:data_wallet/providers/accounts.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/modal_bottom_sheet_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Passwords extends StatelessWidget {
  void showAccInfoModalBottomSheet(BuildContext context, String id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
              child: Column(
                children: [
                  ModalBottomSheetFlatButton(
                    title: 'View',
                    icon: Icons.remove_red_eye_rounded,
                    routeName: AccountInfoPage.routeName,
                    id: id,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountsProvider = Provider.of<Accounts>(context);
    final accounts = accountsProvider.accounts;
    return Container(
      color: Color(0xfffdfcfa),
      child: accounts.length == 0
          ? Center(
              child: Text('No Accounts Yet!'),
            )
          : ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (BuildContext ctx, int i) {
                return GestureDetector(
                  onTap: () => showAccInfoModalBottomSheet(
                    context,
                    accounts[i].id,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(getProportionateScreenHeight(8)),
                    padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                    height: getProportionateScreenHeight(200),
                    decoration: BoxDecoration(
                      color: CustomColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          color: Colors.grey[300],
                          blurRadius: 10.0,
                        ),
                        BoxShadow(
                          offset: const Offset(
                            -1.0,
                            -1.0,
                          ),
                          color: Colors.grey[300],
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              accounts[i].imageUrl,
                              height: getProportionateScreenHeight(60),
                              width: getProportionateScreenHeight(60),
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            Container(
                              height: getProportionateScreenHeight(50),
                              width: getProportionateScreenHeight(50),
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(5)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 3,
                                  color: accounts[i].safetyScore.toInt() < 5
                                      ? Colors.red
                                      : accounts[i].safetyScore.toInt() >= 5 &&
                                              accounts[i].safetyScore.toInt() <=
                                                  8
                                          ? Colors.amber
                                          : Colors.green,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  accounts[i].safetyScore.ceil().toString(),
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(20),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: getProportionateScreenHeight(30),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () async {
                                final status = await accountsProvider
                                    .deleteCredentials(accounts[i].id);
                                if (!status) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Couldn't delete Something went wrong!"),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(
                                getProportionateScreenHeight(8.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    accounts[i].userName,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(18),
                                      color: CustomColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Flexible(
                                  child: Text(
                                    accounts[i].name,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(18),
                                      color: Color(0xff865c32),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
