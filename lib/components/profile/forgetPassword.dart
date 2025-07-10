import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../backButton.dart';
import '../button.dart';
import '../colors/appColor.dart';
import '../textField.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  bool isLoading = false;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> forgotPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackbar("Please enter your email", isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() => isLoading = false);
      showSnackbar("Password reset email sent. Check spam folder");

      // Navigate to the reset password page
      Navigator.pushNamed(context, '/login'); // <-- Change this route if needed
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      String errorMessage = "Something went wrong";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      }

      showSnackbar(errorMessage, isError: true);
    } catch (e) {
      setState(() => isLoading = false);
      showSnackbar("An unexpected error occurred", isError: true);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BackButtonWidget(darkMode: darkMode),
                          SizedBox(width: 4.w),
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      buildLabel("Email", darkMode),
                      CustomTextfield(
                        controller: emailController,
                        focusNode: emailFocus,
                        hintText: "Enter your Email",
                        isPassword: false,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              isLoading
                  ? const CircularProgressIndicator()
                  : Button(
                title: "NEXT",
                textColor: Colors.white,
                bg: AppColors.buttonPrimary,
                onTapCallback: forgotPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label, bool darkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: darkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
