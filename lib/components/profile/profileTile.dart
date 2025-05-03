import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profiletile extends StatelessWidget {
  final bool darkMode;
  final String name;
  final Icon icon;
  final VoidCallback onTapCallback;

  const Profiletile({
    super.key,
    required this.darkMode,
    required this.name,
    required this.icon,
    required this.onTapCallback,
  });

  IconData _getIconFromName(String name) {
    switch (name.toLowerCase()) {
      case 'settings':
        return Icons.settings;
      case 'person':
        return Icons.person;
      case 'logout':
        return Icons.logout;
      case 'notifications':
        return Icons.notifications;
      case 'privacy':
        return Icons.privacy_tip;
      default:
        return Icons.help_outline; // fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: AppColors.containerText,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColors.containerText,
            ),
          ],
        ),
      ),
    );
  }
}