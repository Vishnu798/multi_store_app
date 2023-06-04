import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/beauty_category.dart';
import 'package:multi_store_app/categories/electronics_widget.dart';
import 'package:multi_store_app/categories/home_and_gargen_category.dart';
import 'package:multi_store_app/categories/kids_category.dart';
import 'package:multi_store_app/categories/men_category.dart';
import 'package:multi_store_app/categories/shoe_category.dart';
import 'package:multi_store_app/categories/women_category.dart';
import 'package:multi_store_app/widget/fake_screen.dart';

import '../categories/accessories_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
List <ItemsData> item=[
ItemsData(label: "men"),
ItemsData(label: "women"),
ItemsData(label: "shoes"),
ItemsData(label: "electronics"),
ItemsData(label: "accessories"),
ItemsData(label: "home & garden"),
ItemsData(label: "kids"),
ItemsData(label: "beauty"),

];
final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
    
    
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const FakeSearch() ,
        ),
      body: Stack(children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: sideNavigation(size)
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: categoryView(size)
        )
      ],),
    );
  }


  Widget sideNavigation(Size size){
     // List<String> item = ["men","women","shoes","accessories"];
      return SizedBox(
          height: size.height*0.8,
          width:size.width*0.2,
         
          child:ListView.builder(itemCount: item.length, itemBuilder: (context,index){
            return GestureDetector(
              onTap: () {
                _pageController.jumpToPage(index);
                // for(var elements in item){
                //   elements.isSelected = false;
                // }

                // setState(() {
                //   item[index].isSelected=true;
                // });
              },
              child: Container(
                 color: item[index].isSelected?Colors.white: Colors.grey.shade300,
                height: 100,
                child: Center(child: Text(item[index].label))),
            );
          })
        );
  }
  Widget categoryView(Size size){
    return Container(
          
          height: size.height*0.8,
          width: size.width*0.8,
          color: Colors.white,
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              for(var elements in item){
                  elements.isSelected = false;
                }

                setState(() {
                  item[value].isSelected=true;
                });                                                       
            },
            children: const [
            MenCategory(),
            WomenCategory(),  
            ShoeCategory(),
            ElectronicsCategory(),
            AccessoriesCategory(),
              HomeAndGardenCategory(),
              KidsCategory(),
              BeautyCategory()
                            
          ],
            
          ),
        );
  }

}


class ItemsData{
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected=false,});
}