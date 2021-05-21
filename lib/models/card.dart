import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'card.g.dart';

@HiveType(typeId: 1)
class Card extends HiveObject {
  @HiveField(0)
  final String cardNickName;

  @HiveField(1)
  final String nameOnCard;

  @HiveField(2)
  final String cardNumber;

  @HiveField(3)
  final String valid;

  @HiveField(4)
  final String cvv;

  @HiveField(5)
  final String id;

  Card({
    @required this.cardNickName,
    @required this.nameOnCard,
    @required this.cardNumber,
    @required this.valid,
    @required this.cvv,
    @required this.id,
  });
}
