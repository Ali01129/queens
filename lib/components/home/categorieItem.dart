import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../provider/categorieProvider.dart';

class CategorieItem extends StatelessWidget {
  final String image;
  final String name;
  final bool darkMode;

  const CategorieItem({
    super.key,
    required this.image,
    required this.name,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {

    void onTap(){
      Navigator.pushNamed(context, '/categoriePage');
      Provider.of<CategoryProvider>(context, listen: false).changeCategory(name);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: darkMode ? AppColors.darkcontainer:AppColors.lightcontainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 10.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 1.5.h),
            Text(
              name,
              style: TextStyle(
                color: darkMode?Colors.white:Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
