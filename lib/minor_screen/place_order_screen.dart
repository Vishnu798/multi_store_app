import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/payment_screen.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
 CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
      CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous? anonymous.doc(FirebaseAuth.instance.currentUser!.uid).get():customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Material(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade300,
                  title: AppBarTitle(subCategName: "Place order"),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0,horizontal:16),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Name: ${data['name']}"),
                          Text("Phone: ${data['phone']}"),
                          Text("Address: ${data['address']}")
                        ],),
                      )
                    ),
                    SizedBox(height: 15,),
                    Expanded(
                      child: Container(
                      
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                        child: Consumer<Cart>(builder: (context,cart,child){
                          return ListView.builder(itemCount: cart.count,
                            itemBuilder: ((context, index) {
                              var order = cart.getItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(border: Border.all(width: 3.0,color: Colors.grey.shade500),borderRadius: BorderRadius.circular(20)),
                                child:Row(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      child: SizedBox(height:100,width:100,child: Image.network(order.imagesUrl[0]))
                                    ,),
                                    Column(children: [
                                      Flexible(child: Text(order.name,maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                    Row(children:[
                                      Text(order.price.toStringAsFixed(2),style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                       Text('x ${order.qty.toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),

                                    ])
                                    
                                    ],),
                                    

                                  ],
                                )
                              ),
                            );
                          }));
                        }),
                      ),
                    )
                
                  ],),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width:double.infinity,
                    decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                    child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
                    }, child: Text("confirm ${context.watch<Cart>().totalPrice}",style:TextStyle(color:Colors.white,fontSize:20))),
                  ),
                ),
            
              ),
            ),
          );
  
}
return Scaffold(body: Center(child: CircularProgressIndicator()));
} );}}