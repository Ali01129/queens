import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/auth/others.dart';
import 'package:queens/components/button.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:queens/components/textField.dart';
import 'package:queens/provider/myOrdresProvider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/alert_dialog.dart';
import '../database/userData.dart';
import '../navigation/bottom.dart';
import '../provider/addressProvider.dart';
import '../provider/cartProvider.dart';
import '../provider/userProvider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void login() async {
    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // Try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottom()),
      );

      /// adding data in provider
      final userValue = Provider.of<UserProvider>(context, listen: false);
      final data = await UserData().getUserData();
      UserModel _user=UserModel(name: data?['name'], image: data?['imageUrl'], gender: data?['gender'], phone: data?['phoneNumber'], email:data?['email']);
      userValue.setUser(_user);
      /// ending
      Provider.of<CartProvider>(context, listen: false).setCart();
      Provider.of<Myordresprovider>(context,listen:false).setMyOrders();
      Provider.of<AddressProvider>(context, listen: false).setAddresses();

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showCustomAlertDialog(
        context,
        'Login Failed',
        'Enter valid Email and Password.',
      );
    } catch (e) {
      Navigator.pop(context);
      showCustomAlertDialog(
        context,
        'Error',
        'An unexpected error occurred.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode?Color(0xFF181e22):Colors.white,
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
                    mainAxisSize: MainAxisSize.min, // Makes Column take minimum space vertically
                    children: [
                      Image.asset(
                        darkMode ? 'assets/logo-dark.png' : 'assets/logo-light.png',
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height:6.h),
                      Text("Sign in to your account",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: darkMode?Colors.white:Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
                Text("Email",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: darkMode?Colors.white:Colors.black
                  ),
                ),
                SizedBox(height: 1.h,),
                CustomTextfield(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  hintText: "Enter your email",
                  isPassword: false,
                ),
                SizedBox(height: 2.h,),
                Text("Password",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: darkMode?Colors.white:Colors.black
                  ),
                ),
                SizedBox(height: 1.h,),
                CustomTextfield(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  hintText: "Enter your password",
                  isPassword: true,
                ),
                SizedBox(height: 3.h,),
                Button(title: "SIGN IN", textColor: Colors.white, bg: AppColors.buttonPrimary, onTapCallback: login),
                SizedBox(height: 3.h,),
                Center(
                  child: Text("Forgot Password?",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF0d5ef9)
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: darkMode?Color(0xFF2f3438):Color(0xFFedeeee),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or continue with",
                        style: TextStyle(fontSize: 16,color: darkMode?Colors.white:Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: darkMode?Color(0xFF2f3438):Color(0xFFedeeee),
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Others(),
                SizedBox(height: 2.h,),
                Center(
                  child: RichText(
                      text:TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: darkMode?Colors.white:Colors.black
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF0d5ef9),
                              fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap=(){
                                Navigator.pushReplacementNamed(context, '/register');
                              }
                          ),
                        ]
                      )
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
