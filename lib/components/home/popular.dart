import 'package:flutter/material.dart';
import 'package:queens/components/home/menuItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Popular extends StatelessWidget {
  final bool darkMode;
  const Popular({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    // Sample menu items list
    final List<Map<String, dynamic>> menuItems = [
      {
        "name": "Chicken Burger",
        "image": "assets/burger.png",
        "price": 20,
        "calories": 500,
        "rating": 4.0
      },
      {
        "name": "Chicken Pie",
        "image": "assets/pie.png",
        "price": 18,
        "calories": 450,
        "rating": 4.5
      },
      {
        "name": "Beef Pepperoni",
        "image": "assets/pizza.png",
        "price": 50,
        "calories": 550,
        "rating": 4.0
      },
      {
        "name": "Veggie Wrap",
        "image": "assets/wrap.png",
        "price": 60,
        "calories": 300,
        "rating": 4.2
      },
      {
        "name": "Fish & chips",
        "image": "assets/fish.png",
        "price": 60,
        "calories": 300,
        "rating": 4.2
      },
    ];

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