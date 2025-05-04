import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void showDeleteBottomSheet(BuildContext context, {required bool darkMode,required String text,required IconData icon, required String buttonText, required VoidCallback onDelete}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
    builder: (context) => Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 8.h,
            color: AppColors.buttonPrimary,
          ),
          SizedBox(height: 2.h),
          Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: darkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(fontSize: 16.sp,color: darkMode?Colors.white:Colors.black)),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete(); // callback to perform deletion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                  ),
                  child: Text(buttonText, style: TextStyle(fontSize: 16.sp,color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}