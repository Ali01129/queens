import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../colors/appColor.dart';

class Sendmsg extends StatelessWidget {
  final VoidCallback onTapCallback;
  final TextEditingController controller;
  final bool darkMode;
  final FocusNode focusNode;

  const Sendmsg({
    super.key,
    required this.onTapCallback,
    required this.controller,
    required this.darkMode,
    required this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, top: 0.2.h, bottom: 0.2.h),
      margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
      decoration: BoxDecoration(
        color: darkMode?AppColors.darkcontainer:AppColors.lightcontainer,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: darkMode?Colors.white:Colors.black,
            ),
            onPressed: onTapCallback,
          ),
        ],
      ),
    );
  }
}