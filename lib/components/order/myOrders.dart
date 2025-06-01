import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../provider/myOrdresProvider.dart';
import '../backButton.dart';
import '../colors/appColor.dart';
import 'myOrderItem.dart';

class Myorders extends StatelessWidget {
  const Myorders({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    List<Map<String, dynamic>> orders = Provider.of<Myordresprovider>(context).orders;

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  BackButtonWidget(darkMode: darkMode),
                  SizedBox(width: 4.w),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(  // This makes the listview take remaining space
              child: orders.isEmpty
                  ? Center(
                child: Text(
                  "No orders found",
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Myorderitem(
                      darkMode: darkMode,
                      orderId: order['orderId'],
                      total: order['total'],
                      orderTime: (order['orderTime'] as Timestamp).toDate(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}