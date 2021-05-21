import 'package:data_wallet/models/account.dart';
import 'package:data_wallet/utils/encryption_utils.dart';
import 'package:data_wallet/utils/hash_key_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class Accounts with ChangeNotifier {
  Map<String, String> _urls = {
    'google': 'assets/images/google_logo.jpg',
    'facebook': 'assets/images/fb_logo.png',
  };
  List<Account> _accounts;

  List<Account> get accounts {
    return _accounts;
  }

  Future getLocalData() async {
    Box<Account> accountsBox;

    if (!Hive.isBoxOpen('accounts')) {
      accountsBox = await Hive.openBox<Account>('accounts');
    } else {
      accountsBox = Hive.box<Account>('accounts');
    }
    if (accountsBox != null) {
      if (_accounts == null) {
        _accounts = accountsBox.values.toList();
      }
    }
  }

  Account getAccountById(String id) {
    return _accounts.firstWhere((element) => element.id == id);
  }

  Future<bool> addCredentials(
      Map<String, String> account, String uniPassword) async {
    // final SharedPreferences prefs = await _prefs;
    final key = _urls.keys.toList().firstWhere(
          (element) => account['url'].contains(element),
          orElse: () => null,
        );
    final imageUrl = key != null ? _urls[key] : 'assets/images/default.png';
    final newAccount = Account(
      name: account['name'],
      userName: account['userName'],
      url: account['url'],
      password: encryptData(
        account['password'],
        uniPassword,
      ),
      imageUrl: imageUrl,
      id: hashKeyGenerator(6),
      safetyScore: isPasswordCompliant(account['password']),
    );
    _accounts.add(newAccount);
    final success = await Hive.box<Account>('accounts').add(newAccount);
    notifyListeners();
    return success != null;
  }

  Future<bool> deleteCredentials(String id) async {
    final int index = _accounts.indexWhere((element) => element.id == id);
    _accounts.removeWhere((element) => element.id == id);
    await Hive.box<Account>('accounts').deleteAt(index);
    notifyListeners();
    return true;
  }
}

double isPasswordCompliant(String password, [double minLength = 8]) {
  double safetyScore = 0;
  if (password == null || password.isEmpty) {
    return safetyScore;
  }
  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length >= minLength;
  if (hasUppercase) {
    safetyScore += 2;
  }
  if (hasDigits) {
    safetyScore += 2;
  }
  if (hasLowercase) {
    safetyScore += 2;
  }
  if (hasSpecialCharacters) {
    safetyScore += 2;
  }
  if (hasMinLength) {
    safetyScore += 2;
  }
  return safetyScore;
}
