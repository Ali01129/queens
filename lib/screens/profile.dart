import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queens/database/userData.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/colors/appColor.dart';
import '../components/profile/profileTile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await UserData().getUserData();
    print(data);
    setState(() {
      _userData = data;
    });
    print(data);
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode = _isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                if (_userData != null) ...[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: darkMode?Colors.white:Colors.black, width: 1.w),
                      ),
                      child: CircleAvatar(
                        radius: 14.w,
                        backgroundImage: NetworkImage(_userData!['imageUrl']),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Center(
                    child: Text(_userData!['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ] else
                  Center(child: CircularProgressIndicator()),
                SizedBox(height: 6.h,),
                Profiletile(darkMode: darkMode, name: 'Personal Information', icon: Icon(Icons.person, color: AppColors.containerText), onTapCallback: (){}),
                SizedBox(height: 1.h,),
                Profiletile(darkMode: darkMode, name: 'My Orders', icon: Icon(Icons.shopping_bag, color: AppColors.containerText), onTapCallback: (){}),
                SizedBox(height: 1.h,),
                Profiletile(darkMode: darkMode, name: 'Track Order', icon: Icon(Icons.local_shipping, color: AppColors.containerText), onTapCallback: (){}),
                SizedBox(height: 1.h,),
                Profiletile(darkMode: darkMode, name: 'My Favorites', icon: Icon(Icons.favorite, color: AppColors.containerText), onTapCallback: (){}),
                SizedBox(height: 1.h,),
                Profiletile(darkMode: darkMode, name: 'App Settings', icon: Icon(Icons.settings, color: AppColors.containerText), onTapCallback: (){}),
                SizedBox(height: 1.h,),
                Profiletile(darkMode: darkMode, name: 'Logout', icon: Icon(Icons.logout_rounded, color: AppColors.containerText), onTapCallback: (){_signOut();}),
                SizedBox(height: 1.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}