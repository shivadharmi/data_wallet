import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

Future setPartOfKey() async {
  Box<String> secureStringsBox;
  if (!Hive.isBoxOpen('secureStrings')) {
    secureStringsBox = await Hive.openBox<String>('secureStrings');
  }
  if (secureStringsBox.get('partOfKey') == null) {
    var uuid = Uuid();
    final partKey = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
    secureStringsBox.put('partOfKey', partKey);
  }
}

String encryptData(String data, String uniPassword) {
  final partOfKey = Hive.box<String>('secureStrings').get('partOfKey');
  final _key = uniPassword + partOfKey.substring(0, 32 - uniPassword.length);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(
    encrypt.AES(
      encrypt.Key.fromUtf8(
        _key,
      ),
    ),
  );
  final encrypted = encrypter.encrypt(data, iv: iv);
  return encrypted.base64;
}

String decryptData(String hash, String uniPassword) {
  final partOfKey = Hive.box<String>('secureStrings').get('partOfKey');
  final _key = uniPassword + partOfKey.substring(0, 32 - uniPassword.length);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(
    encrypt.AES(
      encrypt.Key.fromUtf8(
        _key,
      ),
    ),
  );
  final decrypted = encrypter.decrypt64(hash, iv: iv);
  return decrypted;
}
