import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../database/userData.dart';
import '../../provider/addressProvider.dart';
import '../../provider/cartProvider.dart';
import '../../provider/myOrdresProvider.dart';
import '../../provider/userProvider.dart';

class Others extends StatelessWidget {
  const Others({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {

    bool darkMode = isDarkMode(context);

    Future<void> signInWithGoogle(BuildContext context) async {
      try {
        // Begin Google Sign-In
        final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
        if (gUser == null) {
          return; // User canceled the sign-in
        }
        // Obtain auth details
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        // Create credentials
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Sign in with Firebase
        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        final bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

        if (isNewUser) {
          // Navigate to bio (new user)
          Navigator.pushNamedAndRemoveUntil(context, '/bio', (route) => false);
        } else {
          // Navigate to home (existing user)
          Navigator.pushNamedAndRemoveUntil(context, '/bottom', (route) => false);
          ///adding data in provider
          final userValue = Provider.of<UserProvider>(context, listen: false);
          final data = await UserData().getUserData();
          UserModel _user=UserModel(date: data?['dateOfBirth'],name: data?['name'], image: data?['imageUrl'], gender: data?['gender'], phone: data?['phoneNumber'], email:data?['email']);
          userValue.setUser(_user);
          Provider.of<CartProvider>(context, listen: false).setCart();
          Provider.of<Myordresprovider>(context,listen:false).setMyOrders();
          Provider.of<AddressProvider>(context, listen: false).setAddresses();
        }
      } catch (e) {
        print('Google Sign-In error: $e');
        // Optionally show an error message to user
      }
    }

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => signInWithGoogle(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                border: Border.all(
                  width: 2,
                  color: darkMode ? Color(0xFF2f3438) : Color(0xFFedeeee),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google.png", width: 6.w, height: 6.w),
                  SizedBox(width: 2.w),
                  Text(
                    "Google",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}