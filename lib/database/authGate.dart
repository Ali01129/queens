import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/database/userData.dart';
import 'package:queens/navigation/bottom.dart';
import 'package:queens/screens/login.dart';

import '../provider/cartProvider.dart';
import '../provider/myOrdresProvider.dart';
import '../provider/userProvider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _initializeUserData(BuildContext context) async {
    final data = await UserData().getUserData();
    if (data != null) {
      final userModel = UserModel(
        name: data['name'],
        image: data['imageUrl'],
        gender: data['gender'],
        phone: data['phoneNumber'],
        email:data['email'],
      );
      Provider.of<UserProvider>(context, listen: false).setUser(userModel);
      Provider.of<CartProvider>(context, listen: false).setCart();
      Provider.of<Myordresprovider>(context,listen:false).setMyOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            _initializeUserData(context); // Initialize user data here
            return Bottom();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}