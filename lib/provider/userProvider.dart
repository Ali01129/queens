import 'package:flutter/material.dart';

// user model
class UserModel {
  final String name;
  final String image;
  final String gender;
  final String phone;

  UserModel({required this.name, required this.image,required this.gender,required this.phone});
}

// user provider
class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
