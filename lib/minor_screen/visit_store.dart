import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class VisitStore extends StatefulWidget {
  final String suppId;
  const VisitStore({Key? key, required this.suppId}) : super(key: key);

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool isFollow = false;
  CollectionReference users = FirebaseFirestore.instance.collection('suppliers');


  @override
  Widget build(BuildContext context) {

   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('sid', isEqualTo: widget.suppId).snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.suppId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Image.asset('images/inapp/coverimage.jpg',fit: BoxFit.cover,),
              title: Row(children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(border: Border.all(width: 4,color:Colors.yellow), borderRadius: BorderRadius.circular(15)),
                  child: Image.network(data['storelogo'],fit: BoxFit.cover,),
                ),
                Column(children: [
                  Text(data['storename']),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFollow=!isFollow;
                      });
                    },
                    child:data['sid']==FirebaseAuth.instance.currentUser!.uid? Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.black),borderRadius: BorderRadius.circular(15),color: Colors.yellow),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Text('Edit'),
                        Icon(Icons.edit)
                      ],)
                    ): Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.black),borderRadius: BorderRadius.circular(15),color: Colors.yellow),
                      child: Center(child: 
                      Text(isFollow?"FOLLOWING":"FOLLOW",style: TextStyle(color: Colors.black,fontSize: 20),)),
                    ),
                  )
                ],),

              ],),
            ),
            body:  StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(child: Center(child: const CircularProgressIndicator()));
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
    ),
    floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.phone),),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}