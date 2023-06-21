import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/visit_store.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text("Stores"))
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot> (stream: FirebaseFirestore.instance.collection('suppliers').snapshots(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 25, crossAxisSpacing: 25, crossAxisCount: 2), itemBuilder:(context, index) {
            return GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitStore(suppId: snapshot.data!.docs[index]['sid'],)));
              },
              child: Column(
                children: [
                  Stack(children: [
            
                  
                     SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset('images/inapp/store.jpg'),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 28,
                      child: SizedBox(
                      height: 80,width: 100,
                      child: Image.network(snapshot.data!.docs[index]['storelogo'],fit: BoxFit.cover,),
                    ))
                ]),
                  Text(snapshot.data!.docs[index]['storename'])
                ],
              ),
            );
          },);
        }   
        return Center(child: Text("NO stores"));
        },),
      )
    );
}
}