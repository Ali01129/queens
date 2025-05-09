import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Addresstile extends StatelessWidget {
  final bool darkMode;
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const Addresstile({
    super.key,
    required this.darkMode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: isSelected ? AppColors.buttonPrimary : Colors.transparent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 6.h,
              width: 6.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: darkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}