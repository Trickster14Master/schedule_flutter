import 'package:flutter/cupertino.dart';
import 'package:flutter_/models/user.dart';

class User_Provider with ChangeNotifier {
  int _id = 0;
  int get id => _id;

  String _name = "defolt";
  String get name => _name;

  String _mail = "defolt";
  String get mail => _mail;

  String _password = "defolt";
  String get password => _password;

  String _token = "defolt";
  String get token => _token;

  void addUser(User user) {
    _id = user.id;
    _name = user.name;
    _mail = user.mail;
    _password = user.password;
    _token = user.token;
  }
}
