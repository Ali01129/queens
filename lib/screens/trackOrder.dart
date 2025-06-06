import 'package:flutter/material.dart';
import 'package:queens/components/button.dart';
import 'package:queens/components/order/trackDetails.dart';
import 'package:queens/components/textField.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/backButton.dart';
import '../components/colors/appColor.dart';
import '../database/order.dart';

class Trackorder extends StatefulWidget {
  const Trackorder({super.key});

  @override
  State<Trackorder> createState() => _TrackorderState();
}

class _TrackorderState extends State<Trackorder> {
  late TextEditingController trackController;
  FocusNode trackFocusNode = FocusNode();
  Map<String, dynamic>? order;

  @override
  void initState() {
    super.initState();
    trackController = TextEditingController();
  }

  @override
  void dispose() {
    trackController.dispose();
    super.dispose();
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void onTap() async {
    if (trackController.text.isNotEmpty) {
      final result = await Order().trackOrder(orderId: trackController.text);
      if (result == null) {
        print('Order not found');
      } else {
        setState(() {
          order = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    BackButtonWidget(darkMode: darkMode),
                    SizedBox(width: 4.w),
                    Text(
                      'Track Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomTextfield(
                  controller: trackController,
                  focusNode: trackFocusNode,
                  hintText: "Enter Order Number",
                ),
                SizedBox(height: 2.h),
                Button(
                  title: 'Track Order',
                  textColor: Colors.white,
                  bg: AppColors.buttonPrimary,
                  onTapCallback: onTap,
                ),
                if (order != null) ...[
                  SizedBox(height: 2.h),
                  TrackDetails(order: order!, darkMode: darkMode,),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}