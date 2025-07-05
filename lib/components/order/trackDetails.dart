import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:queens/components/order/trackItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackDetails extends StatelessWidget {
  final Map<String, dynamic> order;
  final bool darkMode;

  const TrackDetails({
    super.key,
    required this.order,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime orderDateTime = (order['orderTime'] as Timestamp).toDate();
    final DateTime now = DateTime.now();
    final bool isDelivered = now.difference(orderDateTime).inMinutes > 30;
    final String formattedDate = DateFormat('dd MMM yyyy').format(orderDateTime);
    final String formattedTime = DateFormat('hh:mm a').format(orderDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Order",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          margin: EdgeInsets.only(top: 2.h, right: 2.w),
          decoration: BoxDecoration(
            color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDelivered ? Icons.check_circle_outline : Icons.local_shipping,
                color: isDelivered ? Colors.green : AppColors.lightbg,
              ),
              SizedBox(width: 2.w),
              Text(
                isDelivered ? "Delivered" : "On the way",
                style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, right: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.currency_pound, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      order['total'].toString(),
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, left: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      order['locationName'],
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, right: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_shipping, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      order['delivery'].toString(),
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, left: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.discount, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      order['discount'].toString(),
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, right: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(top: 2.h, left: 2.w),
                decoration: BoxDecoration(
                  color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.watch_later, color: darkMode ? Colors.white : Colors.black),
                    SizedBox(width: 2.w),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Column(
          children: List.generate(order['cartItems'].length, (index) {
            final item = order['cartItems'][index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              child: TrackItem(
                image: item['image'],
                price: item['price'],
                name: item['name'],
                darkMode: darkMode,
                quantity: item['quantity'],
              ),
            );
          }),
        ),
      ],
    );
  }
}