import "package:flutter/material.dart";
import "package:queens/components/backButton.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class Bio extends StatelessWidget {
  const Bio({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Color(0xFF181e22) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButtonWidget(darkMode:darkMode),
                  SizedBox(width: 4.w,),
                  Text("Fill in all fields",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: darkMode?Colors.white:Colors.black
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              Text("Fill all fields for security",
                style: TextStyle(
                  color: darkMode?Colors.white:Colors.black,
                ),
              ),
              SizedBox(height: 2.h,),

            ],
          ),
        ),
      ),
    );
  }
}
