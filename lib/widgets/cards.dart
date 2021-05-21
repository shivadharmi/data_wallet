import 'package:data_wallet/models/card.dart' as CardData;
import 'package:data_wallet/pages/card_info_page.dart';
import 'package:data_wallet/providers/bank_cards.dart';
import 'package:data_wallet/utils/custom_colors.dart';
import 'package:data_wallet/utils/size_config.dart';
import 'package:data_wallet/widgets/modal_bottom_sheet_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bankCards = Provider.of<BankCards>(context);
    final cards = bankCards.cards;
    return Container(
      color: Color(0xfffdfcfa),
      child: cards.length == 0
          ? Center(
              child: Text('No Cards Yet!'),
            )
          : ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext ctx, int i) {
                return CardItem(card: cards[i]);
              },
            ),
    );
  }
}

class CardItem extends StatelessWidget {
  final CardData.Card card;

  const CardItem({
    Key key,
    @required this.card,
  }) : super(key: key);

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
                    routeName: CardInfoPage.routeName,
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
    return GestureDetector(
      onTap: () => showAccInfoModalBottomSheet(
        context,
        card.id,
      ),
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenHeight(8)),
        padding: EdgeInsets.all(getProportionateScreenHeight(15)),
        height: getProportionateScreenHeight(250),
        decoration: BoxDecoration(
          color: CustomColors.bg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(
                0.7,
                0.7,
              ),
              color: Colors.grey[300],
              blurRadius: 10.0,
            ),
            BoxShadow(
              offset: const Offset(
                -0.7,
                -0.7,
              ),
              color: CustomColors.bg.withOpacity(0.6),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  card.cardNickName.split('-')[0],
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primary[200],
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 35,
                    color: Colors.red[600],
                  ),
                  onPressed: () async {},
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'XXXX - XXXX - XXXX - ' + card.cardNickName.split('-')[1],
              style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                fontWeight: FontWeight.bold,
                color: CustomColors.primary,
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Row(
              children: [
                Text(
                  'XXXX',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(22),
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primary,
                  ),
                ),
                Spacer(flex: 4),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(3),
                      height: getProportionateScreenWidth(15),
                      width: getProportionateScreenWidth(15),
                      decoration: BoxDecoration(
                        color: CustomColors.primary[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      height: getProportionateScreenWidth(15),
                      width: getProportionateScreenWidth(15),
                      decoration: BoxDecoration(
                        color: CustomColors.primary[300],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      height: getProportionateScreenWidth(15),
                      width: getProportionateScreenWidth(15),
                      decoration: BoxDecoration(
                        color: CustomColors.primary[400],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 2),
              ],
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(15.0)),
              child: Text(
                card.nameOnCard,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
