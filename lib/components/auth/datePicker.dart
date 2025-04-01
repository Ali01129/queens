import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BirthDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  BirthDatePicker({super.key, required this.controller, required this.focusNode});

  @override
  _BirthDatePickerState createState() => _BirthDatePickerState();
}

class _BirthDatePickerState extends State<BirthDatePicker> {
  final DateFormat _dateFormat = DateFormat('dd/MMMM/yyyy');
  bool _isDateSelected = false;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = _dateFormat.format(pickedDate);
        _isDateSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    Color borderColor = _isDateSelected
        ? Colors.green
        : (widget.focusNode.hasFocus
        ? const Color(0xFF0D5EF9)
        : (darkMode ? const Color(0xFF44484c) : const Color(0xFFe3e3e4)));

    return InkWell(
      onTap: () => _pickDate(context),
      child: IgnorePointer(
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Select Birth Date',
            filled: true,
            fillColor: darkMode ? const Color(0xFF2f3438) : const Color(0xFFF9F9F9),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}