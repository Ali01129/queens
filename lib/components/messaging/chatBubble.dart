import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp time;
  const ChatBubble({super.key,required this.isCurrentUser,required this.message,required this.time});

  @override
  Widget build(BuildContext context) {

    DateTime dateTime = time.toDate();
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    String period = hour >= 12 ? 'PM' : 'AM';
    int formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    String formattedMinute = minute.toString().padLeft(2, '0');
    String Tame='$formattedHour:$formattedMinute $period';

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.buttonPrimary : AppColors.containerText,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 1.w),
          Text(
            Tame,
            style: TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}