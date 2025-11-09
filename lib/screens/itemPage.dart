import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/database/cartData.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/backButton.dart';
import '../components/colors/appColor.dart';
import '../database/menuItemClass.dart';
import '../provider/cartProvider.dart';

class Itempage extends StatelessWidget {
  const Itempage({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuItemArguments;
    bool darkMode = isDarkMode(context);

    final cart=CartData();
    void add_to_cart()async{
      await cart.addToCart(
        userId: FirebaseAuth.instance.currentUser!.uid,
        itemName: args.name,
        price: args.price,
        image: args.image,
      );
      Provider.of<CartProvider>(context, listen: false).setCart();
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top image with back button
                    Stack(
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 40.h,
                          child: Image.asset(
                            args.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 2.h,
                          left: 4.w,
                          child: BackButtonWidget(darkMode: darkMode),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            args.name,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 2.h),

                          // Rating, time, calories row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  SizedBox(width: 1.w),
                                  Text("${args.rating}", style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer, color: darkMode ? Colors.white : Colors.black),
                                  SizedBox(width: 1.w),
                                  Text("20 min", style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department, color: Colors.red),
                                  SizedBox(width: 1.w),
                                  Text("${args.calories} cal", style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          // Description
                          Text(
                            "This delicious ${args.name.toLowerCase()} is made with fresh ingredients and cooked to perfection. Perfect for a quick bite or a full meal. "
                                "Crafted by our expert chefs, it's a blend of tradition and taste that satisfies every craving. "
                                "Served hot and garnished to delight, this dish is not just food—it's an experience worth savoring.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: darkMode ? Colors.grey[300] : Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky bottom bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Divider(color: AppColors.containerText),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "£${args.price}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        onPressed:add_to_cart,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.buttonPrimary,
                        ),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}