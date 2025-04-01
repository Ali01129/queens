import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BackButtonWidget extends StatelessWidget {
  final bool darkMode;
  const BackButtonWidget({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(3.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: darkMode ? Color(0xFF24292d) : Colors.white,
          boxShadow: darkMode
              ? []
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_left,
          size: 4.h,
          color: darkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}