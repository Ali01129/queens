import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Others extends StatelessWidget {
  const Others({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Row(
      children: [
        Expanded(
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
      ],
    );
  }
}