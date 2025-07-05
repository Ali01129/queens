import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../colors/appColor.dart';

class Bill extends StatelessWidget {
  final bool darkMode;
  final double cartTotal;
  final double discount;
  final double total;
  final double delivery;

  const Bill({
    super.key,
    required this.darkMode,
    required this.cartTotal,
    required this.discount,
    required this.delivery,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: darkMode ? AppColors.darkcontainer : AppColors.lightcontainer,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Cart Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cart Total",
                style: TextStyle(color: AppColors.containerText),
              ),
              Text("£ $cartTotal"),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              thickness: 1.5,
              color: Colors.grey,
            ),
          ),

          /// Discount (only show if discount > 0)
          if (discount > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: TextStyle(color: AppColors.containerText),
                ),
                Text("£ $discount"),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 1.5,
                color: AppColors.containerText,
              ),
            ),
          ],

          /// Delivery Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: TextStyle(color: AppColors.containerText),
              ),
              Text("£ $delivery"),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              thickness: 1.5,
              color: AppColors.containerText,
            ),
          ),

          /// Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(color: AppColors.containerText),
              ),
              Text("£ $total"),
            ],
          ),
        ],
      ),
    );
  }
}