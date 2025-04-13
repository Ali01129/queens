import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationIcon extends StatelessWidget {
  final bool darkMode;
  final bool hasNotification;

  const NotificationIcon({
    super.key,
    required this.darkMode,
    required this.hasNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: darkMode?AppColors.darkcontainer:AppColors.lightcontainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        if (hasNotification)
          Positioned(
            bottom: 10,
            right: 11,
            child: Container(
              width: 1.2.h,
              height: 1.2.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
