import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: isChecked ? Color(0xFF0D5EF9) : (darkMode ? Color(0xFF44484c) : Color(0xFFE3E3E4)),
                width: 2,
              ),
              color: isChecked ? Color(0xFF0D5EF9) : Colors.transparent,
            ),
            child: isChecked
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: 5.w,
            )
                : null,
          ),
          SizedBox(width: 3.w),
          Text(
            "Remember me",
            style: TextStyle(
              fontSize: 16.sp,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}