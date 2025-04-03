import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Button extends StatelessWidget {
  String title;
  final Color bg;
  final Color textColor;
  final VoidCallback onTapCallback;
  Button({super.key,required this.title,required this.textColor,required this.bg,required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}