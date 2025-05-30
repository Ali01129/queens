import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String _currentCategory = "Burger";

  String get currentCategory => _currentCategory;

  void changeCategory(String newCategory) {
    _currentCategory = newCategory;
    notifyListeners();
  }
}
