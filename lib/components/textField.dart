import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool Function(String) validator;
  final String hintText;
  final bool isPassword; // New parameter!

  CustomTextfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.validator,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _isValid = false;
  bool _obscureText = true;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  void initState() {
    super.initState();

    // Listen to text changes
    widget.controller.addListener(() {
      final input = widget.controller.text;
      setState(() {
        _isValid = widget.validator(input);
      });
    });

    // Refresh UI on focus change
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    Color borderColor;

    if (_isValid && !widget.focusNode.hasFocus) {
      borderColor = Colors.green;
    } else if (widget.focusNode.hasFocus) {
      borderColor = Color(0xFF0D5EF9);
    } else {
      borderColor = darkMode ? Color(0xFF44484c) : Color(0xFFe3e3e4);
    }

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: darkMode ? Color(0xFF2f3438) : Color(0xFFF9F9F9),
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
        // Password visibility toggle icon
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
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