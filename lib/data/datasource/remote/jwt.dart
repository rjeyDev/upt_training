import 'package:hive_flutter/hive_flutter.dart';

class JwtBox {
  late bool _authenticated;
  late int _id;

  fetchData() async {
    final jwtBox = await Hive.openBox('jwtBox');
    _authenticated = jwtBox.get('authenticated') ?? false;
    _id = jwtBox.get('id') ?? -1;
  }

  storeData() async {
    final jwtBox = await Hive.openBox('jwtBox');
    jwtBox.put('authenticated', _authenticated);
    jwtBox.put('id', _id);
  }

  set authenticated(value) {
    _authenticated = value;
    storeData();
  }

  bool get authenticated => _authenticated;

  set id(value) {
    _id = value;
    storeData();
  }

  int get id => _id;
}
