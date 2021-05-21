import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String userName;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final String id;

  @HiveField(6)
  final double safetyScore;

  Account({
    @required this.name,
    @required this.userName,
    @required this.password,
    @required this.url,
    @required this.imageUrl,
    @required this.safetyScore,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
      "userName": userName,
      "password": password,
      "imageUrl": imageUrl,
      "id": id,
      "safetyScore": safetyScore,
    };
  }

  static Account fromJson(Map<String, dynamic> data) {
    return Account(
        name: data["name"],
        userName: data["userName"],
        password: data["password"],
        url: data["url"],
        imageUrl: data["imageUrl"],
        id: data['id'],
        safetyScore: data['safetyScore']);
  }
}
