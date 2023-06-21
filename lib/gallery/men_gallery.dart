import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class MenGallery extends StatefulWidget {
  const MenGallery({Key? key}) : super(key: key);

  @override
  State<MenGallery> createState() => _MenGalleryState();
}

class _MenGalleryState extends State<MenGallery> {
   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('maincategory', isEqualTo: 'men').snapshots();

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
          return Text("no category found");
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
