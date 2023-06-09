import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/models/product_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SubCategProducts extends StatelessWidget {
  const SubCategProducts({Key? key, required this.subCategName, required this.mainCategName}) : super(key: key);
    final String subCategName;
    final String mainCategName;
  @override
  Widget build(BuildContext context) {
   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').
   where('maincategory', isEqualTo: mainCategName).where('subcategory',isEqualTo: subCategName). snapshots();

    return Scaffold(
      appBar: AppBar(title: AppBarTitle(subCategName: subCategName),),
      body:  StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if(snapshot.data!.docs.isEmpty){
          return Center(
            child: Text("No category found",style: TextStyle(color: Colors.blueGrey.shade700,fontSize: 25,),));
        } 

        return SingleChildScrollView(
          
          child: StaggeredGridView.countBuilder ( itemCount:snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
           crossAxisCount: 2,
           itemBuilder: (context,index){
            return productModel(product:snapshot.data!.docs[index]);
           }, 
           staggeredTileBuilder: (context)=>StaggeredTile.fit(1)),
        );
        
        
      },
    ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.subCategName,
  }) : super(key: key);

  final String subCategName;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(subCategName,style: const TextStyle(fontFamily: 'Acme',color: Colors.black),));
  }
}