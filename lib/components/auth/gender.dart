import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenderDropdown extends StatefulWidget {
  final Function(String) onGenderChanged; // Callback to return selected gender

  const GenderDropdown({Key? key, required this.onGenderChanged}) : super(key: key);

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity, // Full width
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Color(0xFF2F3438), // Updated color
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true, // Makes sure it takes full width
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(color: Colors.green, fontSize: 16.sp),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
                widget.onGenderChanged(value!); // Pass value back to parent
              },
              icon: Icon(Icons.arrow_drop_down, color: Colors.green),
              dropdownColor: Color(0xFF2F3438),
            ),
          ),
        ),
      ],
    );
  }
}