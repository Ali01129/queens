import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../backButton.dart';
import '../colors/appColor.dart';

class Personalinfo extends StatelessWidget {
  const Personalinfo({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {

    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButtonWidget(darkMode: darkMode),
                    SizedBox(width: 4.w),
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}