import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/cartData.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];
  double cart = 0.0;
  double discount = 0.0;
  double delivery=5.0;
  double total=0.0;

  // Set the cart items
  Future<void> setCart() async {
    final cartData = CartData();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final items = await cartData.getCartItems(userId: uid);
    cartItems = items;
    calculate();
    notifyListeners();
  }

  void calculate() {
    cart = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      cart += cartItems[i]['price'] * cartItems[i]['quantity'];
    }
    cart=cart-discount;
    total =cart+delivery;
  }

  void clearCart() {
    cartItems = [];
    cart=0.0;
    total=0.0;
    discount=0.0;
    delivery=5.0;
    final cartData = CartData();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    cartData.clearCart(userId: uid);
    notifyListeners();
  }
}