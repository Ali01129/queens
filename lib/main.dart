import 'package:flutter/material.dart';
import 'package:queens/screens/login.dart';
import 'package:queens/screens/onboarding.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:queens/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Login(),
        );
      },
    );
  }
}