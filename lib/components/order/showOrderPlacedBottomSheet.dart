import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:queens/components/colors/appColor.dart';

void showOrderPlacedBottomSheet(
    BuildContext context, {
      required bool darkMode,
      required String orderId,
      required VoidCallback onHomePressed,
    }) {
  showModalBottomSheet(
    context: context,
    isDismissible: false, // Prevent tap outside to dismiss
    enableDrag: false,    // Prevent swipe down to dismiss
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor:
    darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 4.h,
        left: 4.w,
        right: 4.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Big blue tick in circle
          Container(
            height: 12.h,
            width: 12.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.buttonPrimary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.check_circle,
              size: 10.h,
              color: AppColors.buttonPrimary,
            ),
          ),
          SizedBox(height: 2.h),

          // Main text
          Text(
            "Order Placed",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 1.h),

          // Sub text
          Text(
            "Your order is on the way",
            style: TextStyle(
              fontSize: 16.sp,
              color: darkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          SizedBox(height: 2.h),

          // Order ID
          Text(
            "Order ID: $orderId",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 3.h),

          // Buttons
          Row(
            children: [
              // Home Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onHomePressed();
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),

              // Copy Order ID Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: orderId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Order ID copied to clipboard"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                  ),
                  child: Text(
                    'Copy Order ID',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    ),
  );
}