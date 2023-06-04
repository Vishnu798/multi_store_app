import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_login.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/auth/suppliers_sineup.dart';
import 'package:multi_store_app/screens/customer_home.dart';
import 'package:multi_store_app/screens/supplier_home_screen.dart';
import 'package:multi_store_app/screens/welcome_screen.dart';

import 'auth/suppliers_login.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen':(context) => const WelcomeScreen(),
        '/customer_screen':(context) => const CustomerHomeScreen(),
        '/supplier_screen':(context) => const SupplierHomeScreen(),
        '/customer_login':(context) => const CustomerLogin(),
        '/customer_signup':(context) => const CustomerRegister(),
        '/suppliers_sineup':(context) => const SuppliersRegister(),
        '/supplier_login':(context)=> const SupplierLogin()

      },
    );
  }
}


