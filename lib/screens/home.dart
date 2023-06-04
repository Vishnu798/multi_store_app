import 'package:flutter/material.dart';

import '../widget/fake_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 9,
      child: Scaffold(
       
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom:  const TabBar(isScrollable: true, indicatorColor: Colors.amber, indicatorWeight: 8.0, tabs: [
            RepeatedTabs(text: "Men",),
            RepeatedTabs(text: "Women",),
            RepeatedTabs(text: "Shoes",),
            RepeatedTabs(text: "Bags",),
            RepeatedTabs(text: "Electronics",),
            RepeatedTabs(text: "Accessories",),
            RepeatedTabs(text: "Home and garden",),
            RepeatedTabs(text: "Kids",),
            RepeatedTabs(text: "Beauty",),
        
          ])
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("men screen"),),
            Center(child: Text("women screen"),),
            Center(child: Text("shoes screen"),),
            Center(child: Text("bag screen"),),
            Center(child: Text("electronic screen"),),
            Center(child: Text("accessories screen"),),
            Center(child: Text("home and garden screen"),),
            Center(child: Text("kids screen"),),
            Center(child: Text("beauty screen"),),
           
          ],
        ),
      ),
    );
  }
}



class RepeatedTabs extends StatelessWidget {
  const RepeatedTabs({
    Key? key, required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(text,style: TextStyle(color: Colors.grey.shade600),),);
  }
}