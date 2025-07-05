import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queens/database/order.dart';

class OrderProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];
  double discount = 0.0;
  double total = 0.0;
  double delivery=0.0;
  double cartTotal=0.0;
  String locationName = 'unknown';
  String locationDetails = 'unknown';
  String paymentMethod = 'unknown';
  String paymentStatus = 'unknown';

  /// Initialize order without payment details
  void initializeOrder({
    required List<Map<String, dynamic>> cartItems,
    required double discount,
    required double total,
    required double cartTotal,
    required double delivery,
    required String locationName,
    required String locationDetails,
  }) {
    this.cartItems = cartItems;
    this.discount = discount;
    this.delivery=delivery;
    this.cartTotal=cartTotal;
    this.total = total;
    this.locationName = locationName;
    this.locationDetails = locationDetails;
    notifyListeners();
  }

  void setPayment(String method,String status) {
    paymentMethod = method;
    paymentStatus = status;
    notifyListeners();
  }

  void clearOrder() {
    cartItems = [];
    discount = 0.0;
    total = 0.0;
    cartTotal=0.0;
    locationName = '';
    locationDetails = '';
    paymentMethod = '';
    paymentStatus = '';
    notifyListeners();
  }

  Future<String> add_to_Database() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String orderId = await Order().addOrder( // use an instance of Order
      userId: uid,
      cartItems: cartItems,
      discount: discount,
      delivery:delivery,
      cartTotal:cartTotal,
      total: total,
      locationName: locationName,
      locationDetails: locationDetails,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
    );
    return orderId;
  }


}