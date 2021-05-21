import 'package:data_wallet/models/card.dart';
import 'package:data_wallet/utils/encryption_utils.dart';
import 'package:data_wallet/utils/hash_key_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class BankCards with ChangeNotifier {
  List<Card> _cards;

  List<Card> get cards {
    return _cards;
  }

  Future getLocalData() async {
    Box<Card> cardsBox;
    if (!Hive.isBoxOpen('cards')) {
      cardsBox = await Hive.openBox<Card>('cards');
    } else {
      cardsBox = Hive.box<Card>('cards');
    }
    if (cardsBox != null) {
      if (_cards == null) {
        _cards = cardsBox.values.toList();
      }
    }
  }

  Card getCardById(String id) {
    return _cards.firstWhere((element) => element.id == id);
  }

  Future<bool> addCard(Map<String, String> card, String uniPassword) async {
    final newAccount = Card(
      cardNickName: card['cardNickName'],
      cardNumber: encryptData(card['cardNumber'], uniPassword),
      cvv: encryptData(card['cvv'], uniPassword),
      nameOnCard: card['nameOnCard'],
      valid: encryptData(card['valid'], uniPassword),
      id: hashKeyGenerator(6),
    );
    _cards.add(newAccount);
    final success = await Hive.box<Card>('cards').add(newAccount);
    notifyListeners();
    return success != null;
  }

  Future<bool> deleteCard(String id) async {
    final int index = _cards.indexWhere((element) => element.id == id);
    _cards.removeWhere((element) => element.id == id);
    await Hive.box<Card>('cards').deleteAt(index);
    notifyListeners();
    return true;
  }
}
