import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:queens/components/profile/profileTile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/bottomSheet.dart';
import '../provider/addressProvider.dart';
import '../provider/cartProvider.dart';
import '../provider/myOrdresProvider.dart';
import '../provider/userProvider.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _signOut(BuildContext context) async {
    /// Clear provider states (optional but recommended)
    Provider.of<UserProvider>(context, listen: false).clearUser();
    Provider.of<CartProvider>(context, listen: false).clearCart();
    Provider.of<Myordresprovider>(context,listen:false).clearMyOrder();
    Provider.of<AddressProvider>(context, listen: false).clearAddresses();


    /// sining out
    await FirebaseAuth.instance.signOut();

    /// Navigate to Login screen and clear all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
          (Route<dynamic> route) => false,
    );
  }


  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode = _isDarkMode(context);

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                if (user != null) ...[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: darkMode ? Colors.white : Colors.black,
                          width: 1.w,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 14.w,
                        backgroundImage: NetworkImage(user.image),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Center(
                    child: Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.containerText
                      ),
                    ),
                  ),
                ] else
                  Center(child: CircularProgressIndicator()),
                SizedBox(height: 6.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'Personal Information',
                  icon: Icon(Icons.person, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/personalInfo');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'Change Password',
                  icon: Icon(Icons.lock, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/changePassword');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'My Orders',
                  icon: Icon(Icons.shopping_bag, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/myOrders');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'Track Order',
                  icon: Icon(Icons.local_shipping, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/trackOrder');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'App Settings',
                  icon: Icon(Icons.settings, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/appSettings');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'My Loactions',
                  icon: Icon(Icons.location_on, color: AppColors.containerText),
                  onTapCallback: () {
                    Navigator.pushNamed(context, '/locationPage');
                  },
                ),
                SizedBox(height: 1.h),
                Profiletile(
                  darkMode: darkMode,
                  name: 'Logout',
                  icon: Icon(Icons.power_settings_new, color: AppColors.containerText),
                  onTapCallback: () {
                    showDeleteBottomSheet(
                      context,
                      darkMode: darkMode,
                      text: "Are you sure you want to Logout?",
                      icon: Icons.power_settings_new,
                      buttonText: "Yes, Logout",
                      onDelete: () {
                        _signOut(context);
                      },
                    );
                  },
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}