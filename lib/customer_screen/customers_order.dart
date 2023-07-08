import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/main.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/widget/order_widget.dart';

class CustomersOrders extends StatelessWidget {
  const CustomersOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(subCategName: "Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("some error occured");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  
                  return MyOrder(order:snapshot.data!.docs[index] ,);
                });
          }
          return Center(child: Text("No Data"));
        },
      ),
    );
  }
}



// class Order extends StatelessWidget {
//   final order;
//   const Order({Key? key, this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(border: Border.all(color: Colors.yellow),borderRadius: BorderRadius.circular(25)),
//                       child: ExpansionTile(
//                           title: Row(
//                         children: [
//                           Container(
//                             constraints: BoxConstraints(
//                                 maxHeight: 80, maxWidth: double.infinity),
//                             child: Image.network(order['orderimage']),
//                           ),
//                           Flexible(
//                             child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     order['name'],
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(order['orderprice'].toString()),
//                                   Text(order['orderqty'].toString())
//                                 ],
//                               )
//                             ]),
//                           ),
                     
//                         ],
//                       ),
//                       subtitle:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children:[
//                             Text("see more"),
//                             Text(order['delieverstatus'])

//                           ]
//                           ),
//                           children: [
//                             Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),borderRadius: BorderRadius.circular(15)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                               Text('Name :  ${order['cname']}',style: TextStyle(fontSize: 16),),
//                               Text('Phone :  ${order['phone']}',style: TextStyle(fontSize: 16),),
//                               Text('Email :  ${order['email']}',style: TextStyle(fontSize: 16),),
//                               Text('Address :  ${order['address']}',style: TextStyle(fontSize: 16),),
//                               Text('Mode of Payment :  ${order['paymentStatus']}',style: TextStyle(fontSize: 16),),
//                               Text('Delievery Status :  ${order['delieverstatus']}',style: TextStyle(fontSize: 16),),
//                               Text('Estimate Delievery Date :  ${order['delieverydate']}',style: TextStyle(fontSize: 16),),

//                              order['delieverstatus']=='delieverd' && order['orderreview']==false?TextButton(onPressed: (){}, child: Text("Give review")):Container(height: 0,),
                             
//                             order['delieverstatus']=='delieverd' && order['orderreview']==true?  Row(children: [
//                               Icon(Icons.check),
//                               Text("Review added")
//                              ],):Container(height:0)                            ],),
//                             )
//                           ],
//                       ),
//                     ),
//                   );
//   }
// }


