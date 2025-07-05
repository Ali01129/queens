import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Searchbutton extends StatelessWidget {
  final bool darkMode;

  const Searchbutton({super.key,required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/searchPage');
      },
      child: Container(
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
              child: Text(
                "Search",
                style:  TextStyle(
                  color: AppColors.containerText,
                  fontSize: 16.sp,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
