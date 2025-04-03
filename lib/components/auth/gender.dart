import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenderDropdown extends StatefulWidget {
  final Function(String) onGenderChanged; // Callback to return selected gender

  const GenderDropdown({Key? key, required this.onGenderChanged}) : super(key: key);

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: darkMode ? Colors.white : Colors.black),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.6.h),
          decoration: BoxDecoration(
            color: darkMode?Color(0xFF2F3438):Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color:darkMode ? const Color(0xFF44484c) : const Color(0xFFe3e3e4), width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true,
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(color: darkMode?Colors.white:Colors.black, fontSize: 16.sp),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
                widget.onGenderChanged(value!);
              },
              icon: Icon(Icons.arrow_drop_down, color: darkMode?Colors.white:Colors.black),
              dropdownColor: darkMode?Color(0xFF2F3438):Color(0xFFF9F9F9),
            ),
          ),
        ),
      ],
    );
  }
}
