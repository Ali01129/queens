import 'package:flutter/material.dart';

// user model
class UserModel {
  final String name;
  final String image;
  final String gender;
  final String phone;
  final String email;

  UserModel({required this.name, required this.image,required this.gender,required this.phone,required this.email});
}

// user provider
class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
