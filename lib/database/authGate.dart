import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/database/userData.dart';
import 'package:queens/navigation/bottom.dart';
import 'package:queens/screens/login.dart';

import '../provider/cartProvider.dart';
import '../provider/myOrdresProvider.dart';
import '../provider/userProvider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isUserDataInitialized = false;
  User? _currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Avoid re-running
    if (!_isUserDataInitialized) {
      FirebaseAuth.instance.authStateChanges().first.then((user) async {
        if (user != null) {
          await _initializeUserData();
        }
        setState(() {
          _isUserDataInitialized = true;
          _currentUser = user;
        });
      });
    }
  }

  Future<void> _initializeUserData() async {
    try {
      final data = await UserData().getUserData();
      if (data != null) {
        final userModel = UserModel(
          name: data['name'],
          image: data['imageUrl'],
          gender: data['gender'],
          phone: data['phoneNumber'],
          email: data['email'],
        );

        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        Provider.of<CartProvider>(context, listen: false).setCart();
        Provider.of<Myordresprovider>(context,listen:false).setMyOrders();
      }
    } catch (e) {
      debugPrint('Error initializing user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isUserDataInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _currentUser != null ? Bottom() : const Login();
  }
}
