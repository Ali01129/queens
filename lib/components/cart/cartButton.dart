import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Cartbutton extends StatelessWidget {
  final String title;
  final bool darkMode;
  final VoidCallback onTapCallback;
  final bool? isDisabled;

  const Cartbutton({
    super.key,
    required this.darkMode,
    required this.title,
    required this.onTapCallback,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isDisabled != null && isDisabled! ? Color.fromARGB(255, 132, 172, 247) : AppColors.buttonPrimary,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}