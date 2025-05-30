import 'package:flutter/material.dart';

class Menu {
  final List<Map<String, dynamic>> _menuItems = [
    {
      "name": "Chicken Burger",
      "image": "assets/burger.png",
      "price": 20,
      "calories": 500,
      "rating": 4.0,
      "category": "Burger"
    },
    {
      "name": "Chicken Pie",
      "image": "assets/pie.png",
      "price": 18,
      "calories": 450,
      "rating": 4.5,
      "category": "Pie"
    },
    {
      "name": "Beef Pepperoni",
      "image": "assets/pizza.png",
      "price": 50,
      "calories": 550,
      "rating": 4.0,
      "category": "Pizza"
    },
    {
      "name": "Fish & Chips",
      "image": "assets/fish.png",
      "price": 60,
      "calories": 300,
      "rating": 4.2,
      "category": "Burger"
    },
    {
      "name": "Veggie Wrap",
      "image": "assets/wrap.png",
      "price": 60,
      "calories": 300,
      "rating": 4.2,
      "category": "Wrap"
    },
  ];

  List<Map<String, dynamic>> getAllMenu() {
    return _menuItems;
  }

  List<Map<String, dynamic>> getMenuByCategory(String category) {
    return _menuItems
        .where((item) => item["category"].toString().toLowerCase() == category.toLowerCase())
        .toList();
  }
}