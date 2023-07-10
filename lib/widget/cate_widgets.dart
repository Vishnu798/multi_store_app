import 'package:flutter/material.dart';

import '../minor_screen/sub_categ_products.dart';


class SliderBar extends StatelessWidget {
  const SliderBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height*0.8,width: MediaQuery.of(context).size.width*0.05,
      child: Container(
    decoration: BoxDecoration(color: Colors.brown.withOpacity(0.2)),
    child:  RotatedBox(quarterTurns: 3,
    child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround, 
      children: [
      Text("<<"),
      Text("Men"),
      Text(">>")
    ],),
    ),
      ),
      );
  }
}

class SubCateModel extends StatelessWidget {
  const SubCateModel({
    Key? key, required this.mainCategName, required this.subCategName, required this.assestName, required this.subCategLabel
  }) : super(key: key);
   final String mainCategName;
   final String subCategName;
   final String assestName;
   final String subCategLabel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategProducts(mainCategName: mainCategName,subCategName: subCategName,)));
      },
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
            //  color: Colors.black,
              height: 70,
              width: 70,
              child: Image.asset(assestName)
            ),
          ),
          Text(subCategLabel,style: const TextStyle(fontSize: 15,color: Colors.black),),
        ],
      ),
    );
  }
}

class CateHeaderLabel extends StatelessWidget {
  const CateHeaderLabel({
    Key? key, required this.headerName,
  }) : super(key: key);
    final String headerName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(headerName,style: const TextStyle(fontSize: 24,color:Colors.black),),
    );
  }
}