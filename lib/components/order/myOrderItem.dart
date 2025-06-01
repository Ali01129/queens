import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../colors/appColor.dart';

class Myorderitem extends StatelessWidget {
  final bool darkMode;
  final String orderId;
  final double total;
  final DateTime orderTime;

  const Myorderitem({
    super.key,
    required this.darkMode,
    required this.orderId,
    required this.total,
    required this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
    darkMode ? AppColors.darkcontainer : AppColors.lightcontainer;
    final borderColor =
    darkMode ? AppColors.lightcontainer : AppColors.darkcontainer;

    final formattedDate = DateFormat.yMMMEd().format(orderTime);
    final formattedTime = DateFormat.jm().format(orderTime);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🆔 Order ID with copy button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Order # $orderId",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy, color: darkMode ? Colors.white : Colors.black),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: orderId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order ID copied to clipboard')),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // 💷 Total
          Text(
            'Total: £$total',
            style: TextStyle(
              color: darkMode ? Colors.white : Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 0.8.h),

          // 📅 Date & ⏰ Time
          Text(
            'Date: $formattedDate',
            style: TextStyle(
              color: darkMode ? Colors.grey[300] : Colors.grey[800],
              fontSize: 14.sp,
            ),
          ),
          Text(
            'Time: $formattedTime',
            style: TextStyle(
              color: darkMode ? Colors.grey[300] : Colors.grey[800],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}