import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenderDropdown extends StatelessWidget {
  final Function(String) onGenderChanged;
  final String initialVal;

  const GenderDropdown({
    Key? key,
    required this.onGenderChanged,
    required this.initialVal,
  }) : super(key: key);

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    final genderOptions = ['Male', 'Female', 'Other'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.6.h),
          decoration: BoxDecoration(
            color: darkMode ? const Color(0xFF2F3438) : const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: darkMode ? const Color(0xFF44484c) : const Color(0xFFe3e3e4),
              width: 1.5,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: genderOptions.contains(initialVal)
                  ? initialVal
                  : genderOptions[0],
              isExpanded: true,
              items: genderOptions.map(
                    (gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(
                      gender,
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  onGenderChanged(value);
                }
              },
              icon: Icon(
                Icons.arrow_drop_down,
                color: darkMode ? Colors.white : Colors.black,
              ),
              dropdownColor: darkMode
                  ? const Color(0xFF2F3438)
                  : const Color(0xFFF9F9F9),
            ),
          ),
        ),
      ],
    );
  }
}