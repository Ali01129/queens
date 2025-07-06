import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  // Method to save user data
  Future<void> saveUserData({
    required String name,
    required String gender,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await firestore.collection('users').doc(uid).set({
        'name': name,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'uid': uid,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Method to retrieve user data
  Future<Map<String, dynamic>?> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (docSnapshot.exists) {
      return docSnapshot.data();
    } else {
      return null;
    }
  }

// Method to update existing user data
  Future<void> updateUserData({
    required String name,
    required String gender,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('users').doc(uid).update({
        'name': name,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'updatedAt': FieldValue.serverTimestamp(), // optional
      });
    } on FirebaseException catch (e) {
      print("Failed to update user data: ${e.message}");
      rethrow; // Rethrow to handle it where this function is called
    }
  }

}
