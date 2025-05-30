import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addOrder({
    required String userId,
    required List<Map<String, dynamic>> cartItems,
    required double discount,
    required double total,
    required String locationName,
    required String locationDetails,
    required String paymentMethod,
    required String paymentStatus,
  }) async {
    final ordersRef = _firestore.collection('users').doc(userId).collection('orders');

    final DateTime now = DateTime.now();
    final Timestamp timestamp = Timestamp.fromDate(now);

    final String orderId = ordersRef.doc().id; // Firestore auto-ID

    final orderData = {
      'orderId': orderId,
      'cartItems': cartItems,
      'discount': discount,
      'total': total,
      'locationName': locationName,
      'locationDetails': locationDetails,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderTime': timestamp,
    };

    await ordersRef.doc(orderId).set(orderData);

    return orderId;
  }

  /// track order by order id
  Future<Map<String, dynamic>?> trackOrder({
    required String orderId,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final orderDoc = _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId);

    final docSnapshot = await orderDoc.get();

    if (docSnapshot.exists) {
      return docSnapshot.data();
    } else {
      return null; // Order not found
    }
  }

  /// get all orders
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ordersRef = _firestore.collection('users').doc(uid).collection('orders');

    final querySnapshot = await ordersRef.orderBy('orderTime', descending: true).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  /// for calling this function
  // final orderService = Order();
  // List<Map<String, dynamic>> orders = await orderService.getAllOrders();

}