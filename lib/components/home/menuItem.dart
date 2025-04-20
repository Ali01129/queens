import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../database/menuItemClass.dart';
import '../colors/appColor.dart';

class Menuitem extends StatelessWidget {
  final bool darkMode;
  final String name;
  final int price;
  final double rating;
  final int calories;
  final String image;

  const Menuitem({
    super.key,
    required this.darkMode,
    required this.calories,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
    darkMode ? AppColors.darkcontainer : AppColors.lightcontainer;
    final borderColor =
    darkMode ? AppColors.lightcontainer : AppColors.darkcontainer;

    return SizedBox(
      width: 40.w,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ Rating aligned right
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  SizedBox(width: 1.w),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                height: 10.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 1.w),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 1.w),
            Text(
              '$calories Kcal',
              style: TextStyle(
                fontSize: 13.sp,
                color: darkMode ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
            SizedBox(height: 1.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£$price',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 5.h,
                  decoration: BoxDecoration(
                    color: darkMode ? Colors.white : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {Navigator.pushNamed(context, '/item',
                      arguments: MenuItemArguments(
                        darkMode: darkMode,
                        name: name,
                        price: price,
                        rating: rating,
                        calories: calories,
                        image: image,
                      ),
                    );},
                    icon: Icon(Icons.add,
                        color: darkMode ? Colors.black : Colors.white),
                    iconSize: 18.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}