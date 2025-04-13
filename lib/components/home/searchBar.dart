import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController controller;
  final bool darkMode;

  const Searchbar({super.key, required this.controller,required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: darkMode?AppColors.darkcontainer:AppColors.lightcontainer,
        borderRadius: BorderRadius.circular(12.w), // rounded corners
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: darkMode?Colors.white:Colors.black),
          SizedBox(width: 2.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: darkMode?Colors.white:Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColors.containerText),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
