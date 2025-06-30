import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/address.dart';

class AddressProvider extends ChangeNotifier {
  List<Map<String, dynamic>> addresses = [];

  // Fetch and set addresses from Firebase
  Future<void> setAddresses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final locationData = LocationData();
    final fetchedAddresses = await locationData.getLocations(userId: uid);
    addresses = fetchedAddresses;
    notifyListeners();
  }

  // Clear addresses from provider
  void clearAddresses() {
    addresses = [];
    notifyListeners();
  }
}


// To fetch and update addresses
// Provider.of<AddressProvider>(context, listen: false).setAddresses();
//
// // To clear addresses
// Provider.of<AddressProvider>(context, listen: false).clearAddresses();
