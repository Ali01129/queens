import 'package:flutter/material.dart';
import 'package:queens/components/order/myOrders.dart';
import 'package:queens/components/home/categoriePage.dart';
import 'package:queens/database/authGate.dart';
import 'package:queens/navigation/bottom.dart';
import 'package:queens/provider/addressProvider.dart';
import 'package:queens/provider/categorieProvider.dart';
import 'package:queens/provider/myOrdresProvider.dart';
import 'package:queens/provider/orderProvider.dart';
import 'package:queens/screens/addressPage.dart';
import 'package:queens/screens/bio.dart';
import 'package:queens/screens/itemPage.dart';
import 'package:queens/screens/locationPage.dart';
import 'package:queens/screens/login.dart';
import 'package:queens/screens/mapPage.dart';
import 'package:queens/screens/messaging.dart';
import 'package:queens/screens/onboarding.dart';
import 'package:queens/screens/paymentPage.dart';
import 'package:queens/screens/register.dart';
import 'package:queens/screens/trackOrder.dart';
import 'package:queens/screens/uploadPhoto.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
//provider
import 'package:provider/provider.dart';
import 'package:queens/provider/userProvider.dart';
import 'package:queens/provider/cartProvider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: "https://wchadsxxtwetepaarxki.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjaGFkc3h4dHdldGVwYWFyeGtpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4NjE0ODUsImV4cCI6MjA2MTQzNzQ4NX0.fZMYjsc7JaazScrlzdniLjj5t2zEty1hg5R3_MSTc3k"
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>UserProvider()),
          ChangeNotifierProvider(create: (context)=>CartProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (context)=>OrderProvider()),
          ChangeNotifierProvider(create: (context)=>Myordresprovider()),
          ChangeNotifierProvider(create: (context)=>AddressProvider()),
        ],
        child: MyApp() ,
      ),
  );
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
            '/':(context)=>const Onboarding(),
            '/login':(context)=>const Login(),
            '/register':(context)=>const Register(),
            '/uploadPhoto':(context)=>const Uploadphoto(),
            '/bio':(context)=>const Bio(),
            '/bottom':(context)=> Bottom(),
            '/item':(context)=>Itempage(),
            '/authgate':(context)=>AuthGate(),
            '/addressPage':(context)=>Addresspage(),
            '/paymentPage':(context)=>Paymentpage(),
            '/categoriePage':(context)=>Categoriepage(),
            '/trackOrder':(context)=>Trackorder(),
            '/myOrders':(context)=>Myorders(),
            '/messaging':(context)=>Messaging(),
            '/mapPage':(context)=>MapPage(),
            '/locationPage':(context)=>Locationpage(),
          },
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }
}