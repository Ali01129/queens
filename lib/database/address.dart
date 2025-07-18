import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Add location (with name and coordinates), ensuring name is unique
  Future<void> addLocation({
    required String locationName,
    required double latitude,
    required double longitude,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final locationRef = _firestore.collection('users').doc(uid).collection('locations');
    final existingLocation = await locationRef.doc(locationName).get();

    if (existingLocation.exists) {
      throw Exception("Location with this name already exists.");
    }

    await locationRef.doc(locationName).set({
      'name': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // 2. Get all locations for a user
  Future<List<Map<String, dynamic>>> getLocations() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final locationRef = _firestore.collection('users').doc(uid).collection('locations');
    final querySnapshot = await locationRef.get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 3. Delete location by name
  Future<void> deleteLocation({required String locationName}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final locationDoc = _firestore.collection('users').doc(uid).collection('locations').doc(locationName);
    await locationDoc.delete();
  }
}

// final locationData = LocationData();
//
// // Add
// await locationData.addLocation(
// userId: 'user123',
// locationName: 'Home',
// latitude: 24.8607,
// longitude: 67.0011,
// );
//
// // Get all
// final locations = await locationData.getLocations(userId: 'user123');
//
// // Delete
// await locationData.deleteLocation(userId: 'user123', locationName: 'Home');
