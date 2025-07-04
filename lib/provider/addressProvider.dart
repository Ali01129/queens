import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/address.dart';

class AddressProvider extends ChangeNotifier {
  List<Map<String, dynamic>> addresses = [];

  // Fetch and set addresses from Firebase
  Future<void> setAddresses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final locationData = AddressData();
    final fetchedAddresses = await locationData.getLocations();
    addresses = fetchedAddresses;
    notifyListeners();
  }

  // Clear addresses from provider
  void clearAddresses() {
    addresses = [];
    notifyListeners();
  }

  // delete a location
  Future<void> deleteAddresses(String title) async {
    final locationData = AddressData();
    await locationData.deleteLocation(locationName: title);
    await setAddresses(); // make sure this is async
    notifyListeners();
  }
}


// To fetch and update addresses
// Provider.of<AddressProvider>(context, listen: false).setAddresses();
//
// // To clear addresses
// Provider.of<AddressProvider>(context, listen: false).clearAddresses();
