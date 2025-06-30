import 'package:flutter/material.dart';
import 'package:queens/components/button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:queens/components/colors/appColor.dart';

void showAddLocationBottomSheet(
    BuildContext context, {
      required bool darkMode,
      required TextEditingController controller,
      required VoidCallback onAdd,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Ensures the keyboard doesn't cover the sheet
    backgroundColor:
    darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 4.w,
          right: 4.w,
          top: 4.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: darkMode ? Colors.white : Colors.black,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            // TextField
            TextField(
              controller: controller,
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Enter location name',
                hintStyle: TextStyle(
                  color: darkMode ? Colors.white54 : Colors.black54,
                ),
                filled: true,
                fillColor:
                darkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            // Add to Location button
            Button(title: "Add to Location", textColor: AppColors.lightbg, bg: AppColors.buttonPrimary, onTapCallback: (){
              Navigator.pop(context);
              onAdd();
            }),
            SizedBox(height: 2.h),
          ],
        ),
      );
    },
  );
}