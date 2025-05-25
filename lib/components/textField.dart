import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool isPassword;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  void initState() {
    super.initState();

    // Refresh UI on focus change
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    Color borderColor = widget.focusNode.hasFocus
        ? const Color(0xFF0D5EF9) // Blue when focused
        : Colors.transparent;     // Transparent when not focused

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType:
      widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: darkMode ? const Color(0xFF2f3438) : const Color(0xFFF9F9F9),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}