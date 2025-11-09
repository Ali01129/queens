import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:queens/components/home/categories.dart';
import 'package:queens/components/home/horizontalScroll.dart';
import 'package:queens/components/home/notification.dart';
import 'package:queens/components/home/popular.dart';
import 'package:queens/components/home/searchButton.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatelessWidget {
  Home({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  TextEditingController searchController = TextEditingController();

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
                      Expanded(child: Searchbutton(darkMode: darkMode,)),
                      // SizedBox(width: 2.w,),
                      // NotificationIcon(darkMode: darkMode, hasNotification: true)
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  HorizontalImageCarousel(darkMode:darkMode,),
                  SizedBox(height: 4.w,),
                  Categories(darkMode: darkMode),
                  SizedBox(height: 4.w,),
                  Popular(darkMode: darkMode),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
