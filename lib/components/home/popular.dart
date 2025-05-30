import 'package:flutter/material.dart';
import 'package:queens/components/home/menuItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../database/menu.dart';

class Popular extends StatelessWidget {
  final bool darkMode;
  const Popular({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    // Sample menu items list
    final menu = Menu();
    final menuItems = menu.getAllMenu();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular this week",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 2.h),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 2.h,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 0.75,
          children: menuItems.map((item) {
            return Menuitem(
              darkMode: darkMode,
              calories: item['calories'],
              name: item['name'],
              price: item['price'],
              rating: item['rating'],
              image: item['image'],
            );
          }).toList(),
        ),
      ],
    );
  }
}