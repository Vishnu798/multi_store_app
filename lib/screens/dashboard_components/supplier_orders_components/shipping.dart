import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screen/customers_order.dart';
import 'package:multi_store_app/widget/order_widget.dart';
import 'package:multi_store_app/widget/supplier_preparing_order.dart';


class Shipping extends StatefulWidget {
  const Shipping({Key? key}) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('delieverstatus', isEqualTo: 'shipping')
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
                  
                  return SupplierPreparingOrder(order: snapshot.data!.docs[index],);
                });
          }
          return Center(child: Text("No Data"));
        },
      );
  }
}

