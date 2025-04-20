import 'package:flutter/material.dart';
import 'package:queens/components/button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/onboarding.png"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Queens Grill and Fish Bar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 2.h,),
              Text("Savor the convenience of restaurant-quality meals, delivered promptly.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h,),
              Button(
                title: "NEXT",bg: Colors.white,textColor: Colors.black,
                onTapCallback: (){
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      ),
    );
  }
}
