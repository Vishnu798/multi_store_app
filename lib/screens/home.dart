import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/kids_category.dart';
import 'package:multi_store_app/gallery/accessorie_gallery.dart';
import 'package:multi_store_app/gallery/bag_gallery.dart';
import 'package:multi_store_app/gallery/beauty_gallery.dart';
import 'package:multi_store_app/gallery/electronic_gallery.dart';
import 'package:multi_store_app/gallery/home_garden_gallery.dart';
import 'package:multi_store_app/gallery/men_gallery.dart';
import 'package:multi_store_app/gallery/shoe_gallery.dart';
import 'package:multi_store_app/gallery/women_gallery.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

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
       backgroundColor: Colors.blueGrey.shade200.withOpacity(0.6),
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
           MenGallery(),
          WomenGallery() ,
          ShoeGallery() ,
          BagGallery(),
          Electric(),
          Accesss(),
          HomeGardenGallery(),
            KidsCategory(),
            BeautyGallery(),
           
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