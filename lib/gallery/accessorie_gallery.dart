import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class Accesss extends StatefulWidget {
  const Accesss({Key? key}) : super(key: key);

  @override
  State<Accesss> createState() => _AccesssState();
}

class _AccesssState extends State<Accesss> {
   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('maincategory', isEqualTo: 'accessories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
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
    );
  }
}
