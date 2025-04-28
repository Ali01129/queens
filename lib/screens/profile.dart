import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final user=FirebaseAuth.instance.currentUser!;
  void signout(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(onPressed: signout, icon: Icon(Icons.logout_rounded)),
            Center(child: Text(user.email!)),
          ],
        ),
      ),
    );
  }
}
