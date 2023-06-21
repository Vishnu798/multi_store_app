

import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/category.dart';
import 'package:multi_store_app/screens/dashboard_screen.dart';
import 'package:multi_store_app/screens/home.dart';
import 'package:multi_store_app/screens/story_screen.dart';
import 'package:multi_store_app/screens/upload_products.dart';

class SupplierHomeScreen extends StatefulWidget {
    const SupplierHomeScreen({Key? key}) : super(key: key);
 
  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();

}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
   int selectedIndex=0;
   List tab = const [
    HomeScreen(),
   CategoryScreen(),
    StoryScreen(),
     DashboardScreen(),
    UploadProductScreen()
  
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab[selectedIndex],
      bottomNavigationBar: BottomNavigationBar( type: BottomNavigationBarType.fixed, selectedItemColor: Colors.black, unselectedItemColor: Colors.red, currentIndex: selectedIndex, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "category"),
         BottomNavigationBarItem(icon: Icon(Icons.shop),label: "store"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Upload")
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