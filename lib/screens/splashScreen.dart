import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              darkMode ? 'assets/bg_dark.png' : 'assets/bg_light.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            darkMode ? 'assets/logo-dark.png' : 'assets/logo-light.png',
            width: 60.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}