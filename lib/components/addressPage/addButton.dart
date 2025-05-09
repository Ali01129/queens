import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Addbutton extends StatelessWidget {
  final bool darkMode;
  final String title;
  final VoidCallback onTapCallback;
  const Addbutton({super.key,required this.darkMode, required this.title, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkMode?Color(0xFF172438):Color(0xFFD8EDF9),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.buttonPrimary,
              fontSize: 17.sp,
            ),
          ),
        ),
      ),
    );
  }
}
