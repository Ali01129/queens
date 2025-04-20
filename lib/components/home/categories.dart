import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:queens/components/home/categorieItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Categories extends StatelessWidget {
  final bool darkMode;
  const Categories({super.key,required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore Menu",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: darkMode?Colors.white:Colors.black
          ),
        ),
        SizedBox(height: 4.w,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategorieItem(image: "assets/burger.png", name: "Burger", darkMode: darkMode),
              SizedBox(width: 2.w,),
              CategorieItem(image: "assets/pizza.png", name: "Pizza", darkMode: darkMode),
              SizedBox(width: 2.w,),
              CategorieItem(image: "assets/pie.png", name: "Pie", darkMode: darkMode),
              SizedBox(width: 2.w,),
              CategorieItem(image: "assets/naan.png", name: "Naan", darkMode: darkMode),
              SizedBox(width: 2.w,),
              CategorieItem(image: "assets/fish.png", name: "Fish&chips", darkMode: darkMode),
              SizedBox(width: 2.w,),
              CategorieItem(image: "assets/wrap.png", name: "Wrap", darkMode: darkMode),
            ],
          ),
        ),
      ],
    );
  }
}
