

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/cart_screen.dart';
import 'package:multi_store_app/screens/category.dart';
import 'package:multi_store_app/screens/home.dart';
import 'package:multi_store_app/screens/profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
    const CustomerHomeScreen({Key? key}) : super(key: key);
 
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();

}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
   int selectedIndex=0;
   List tab =  [
    HomeScreen(),
   CategoryScreen(),
    Center(child: Text("store screen")),
  CartScreen(),
    ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid,)
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab[selectedIndex],
      bottomNavigationBar: BottomNavigationBar( type: BottomNavigationBarType.fixed, selectedItemColor: Colors.black, unselectedItemColor: Colors.red, currentIndex: selectedIndex, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "category"),
         BottomNavigationBarItem(icon: Icon(Icons.shop),label: "store"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile")
      ],
      onTap: (value) {
        setState(() {
        selectedIndex = value;   
        });
      },
      ),
    );
  }
}