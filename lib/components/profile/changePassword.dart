import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backButton.dart';
import '../button.dart';
import '../colors/appColor.dart';
import '../textField.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final oldFocus = FocusNode();
  final newFocus = FocusNode();
  final confirmFocus = FocusNode();

  bool isLoading = false;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      showSnackbar("New passwords do not match");
      return;
    }

    if (newPasswordController.text.length < 6) {
      showSnackbar("New password must be at least 6 characters");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPasswordController.text,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPasswordController.text);

      showSnackbar("Password changed successfully");
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.message ?? "Something went wrong");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldFocus.dispose();
    newFocus.dispose();
    confirmFocus.dispose();
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
                            "Change Password",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      buildLabel("Old Password", darkMode),
                      CustomTextfield(
                        controller: oldPasswordController,
                        focusNode: oldFocus,
                        hintText: "Enter your old password",
                        isPassword: true,
                      ),
                      SizedBox(height: 2.h),
                      buildLabel("New Password", darkMode),
                      CustomTextfield(
                        controller: newPasswordController,
                        focusNode: newFocus,
                        hintText: "Enter new password",
                        isPassword: true,
                      ),
                      SizedBox(height: 2.h),
                      buildLabel("Confirm New Password", darkMode),
                      CustomTextfield(
                        controller: confirmPasswordController,
                        focusNode: confirmFocus,
                        hintText: "Enter new password again",
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              isLoading
                  ? CircularProgressIndicator()
                  : Button(
                title: "Change Password",
                textColor: Colors.white,
                bg: AppColors.buttonPrimary,
                onTapCallback: changePassword,
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