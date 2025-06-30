import 'package:cloud_firestore/cloud_firestore.dart';

class CartData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Add item to cart
  Future<void> addToCart({required String userId, required String itemName, required int price, required String image}) async {
    final cartRef = _firestore.collection('users').doc(userId).collection('cart');
    final itemDoc = cartRef.doc(itemName);
    final docSnapshot = await itemDoc.get();

    if (docSnapshot.exists) {
      final currentQuantity = docSnapshot.data()?['quantity'] ?? 1;
      await itemDoc.update({'quantity': currentQuantity + 1, 'updatedAt': FieldValue.serverTimestamp(),});
    } else {
      await itemDoc.set({'name': itemName, 'quantity': 1, 'price': price, 'image':image, 'addedAt': FieldValue.serverTimestamp(),});
    }
  }

  // 2. Edit item quantity in cart
  Future<void> editCartQuantity({required String userId, required String itemName, required int newQuantity,}) async {
    final itemDoc = _firestore.collection('users').doc(userId).collection('cart').doc(itemName);
    await itemDoc.update({'quantity': newQuantity, 'updatedAt': FieldValue.serverTimestamp(),});
  }

  // 3. Delete item from cart
  Future<void> deleteFromCart({required String userId, required String itemName,}) async {
    final itemDoc = _firestore.collection('users').doc(userId).collection('cart').doc(itemName);
    await itemDoc.delete();
  }

  // 4. get list of items
  Future<List<Map<String, dynamic>>> getCartItems({required String userId}) async {
    final cartRef = _firestore.collection('users').doc(userId).collection('cart');
    final querySnapshot = await cartRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 5. Clear all items from the cart
  Future<void> clearCart({required String userId}) async {
    final cartRef = _firestore.collection('users').doc(userId).collection('cart');
    final cartItems = await cartRef.get();
    for (var doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }
}