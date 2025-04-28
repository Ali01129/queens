import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/auth/others.dart';
import 'package:queens/components/button.dart';
import 'package:queens/components/checkBox.dart';
import 'package:queens/components/textField.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/alert_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode repeatPasswordFocusNode = FocusNode();

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  bool _validateRepeatPassword(String password) {
    return password == passwordController.text;
  }

  void register()async{
    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    // try to register
    if(passwordController.text==repeatPasswordController.text){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushNamed(context, '/bio');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.pop(context);
          showCustomAlertDialog(
            context,
            'Error',
            'The password provided is too weak.',
          );
        } else if (e.code == 'email-already-in-use') {
          Navigator.pop(context);
          showCustomAlertDialog(
            context,
            'Error',
            'The account already exists for that email.',
          );
        }
      } catch (e) {
        Navigator.pop(context);
        showCustomAlertDialog(
          context,
          'Error',
          'Unexpected Error occurred.',
        );
      }
    }
    else{
      showCustomAlertDialog(
        context,
        'Error',
        'Password and Confirm Password does not match.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Color(0xFF181e22) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        darkMode ? 'assets/logo-dark.png' : 'assets/logo-light.png',
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Create a new account",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 1.h),
                CustomTextfield(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  validator: _validateEmail,
                  hintText: "Enter your email",
                  isPassword: false,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 1.h),
                CustomTextfield(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  validator: _validatePassword,
                  hintText: "Enter your password",
                  isPassword: true,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Repeat Password",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 1.h),
                CustomTextfield(
                  controller: repeatPasswordController,
                  focusNode: repeatPasswordFocusNode,
                  validator: _validateRepeatPassword,
                  hintText: "Re-enter your password",
                  isPassword: true,
                ),
                SizedBox(height: 1.h),
                CustomCheckbox(),
                SizedBox(height: 3.h),
                Button(
                  title: "SIGN UP",
                  textColor: Colors.white,
                  bg: Color(0xFF0d5ef9),
                  onTapCallback: register,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: darkMode ? Color(0xFF2f3438) : Color(0xFFedeeee),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: 16,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: darkMode ? Color(0xFF2f3438) : Color(0xFFedeeee),
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Others(),
                SizedBox(height: 2.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xFF0d5ef9),
                            fontWeight: FontWeight.bold,
                          ),
                            recognizer: TapGestureRecognizer()
                              ..onTap=(){
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}