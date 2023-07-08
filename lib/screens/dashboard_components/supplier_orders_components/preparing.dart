import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screen/customers_order.dart';
import 'package:multi_store_app/widget/order_widget.dart';
import 'package:multi_store_app/widget/supplier_preparing_order.dart';

class Preparing extends StatefulWidget {
  const Preparing({Key? key}) : super(key: key);

  @override
  State<Preparing> createState() => _PreparingState();
}

class _PreparingState extends State<Preparing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('delieverstatus', isEqualTo: 'preparing')
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
                  
                  return SupplierPreparingOrder(order:snapshot.data!.docs[index] ,);
                });
          }
          return Center(child: Text("No Data"));
        },
      );
  }
}

