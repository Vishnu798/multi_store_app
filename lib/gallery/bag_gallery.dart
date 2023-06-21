import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class BagGallery extends StatefulWidget {
  const BagGallery({Key? key}) : super(key: key);

  @override
  State<BagGallery> createState() => _BagGalleryState();
}

class _BagGalleryState extends State<BagGallery> {
   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('maincategory', isEqualTo: 'bags').snapshots();

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
