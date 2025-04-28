import 'package:flutter/material.dart';
import 'package:queens/database/authGate.dart';
import 'package:queens/navigation/bottom.dart';
import 'package:queens/screens/bio.dart';
import 'package:queens/screens/itemPage.dart';
import 'package:queens/screens/login.dart';
import 'package:queens/screens/onboarding.dart';
import 'package:queens/screens/register.dart';
import 'package:queens/screens/uploadPhoto.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:queens/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: "https://wchadsxxtwetepaarxki.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjaGFkc3h4dHdldGVwYWFyeGtpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4NjE0ODUsImV4cCI6MjA2MTQzNzQ4NX0.fZMYjsc7JaazScrlzdniLjj5t2zEty1hg5R3_MSTc3k"
  );
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
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login':(context)=>const Login(),
            '/register':(context)=>const Register(),
            '/onboarding':(context)=>const Onboarding(),
            '/uploadPhoto':(context)=>const Uploadphoto(),
            '/bio':(context)=>const Bio(),
            '/bottom':(context)=> Bottom(),
            '/item':(context)=>Itempage(),
            '/authgate':(context)=>AuthGate(),
          },
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }
}