import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:queens/components/colors/appColor.dart';

class TrackItem extends StatelessWidget {
  final bool darkMode;
  final String name;
  final int price;
  final String image;
  final int quantity;

  const TrackItem({
    super.key,
    required this.image,
    required this.price,
    required this.name,
    required this.darkMode,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(2.w),
            child: Image.asset(
              image,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 4.w),

          // Name and Price Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '£ $price',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: darkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Display
          Text(
            'x$quantity',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}