import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int seletedPaymentOption = 1;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseAuth.instance.currentUser!.isAnonymous
            ? anonymous.doc(FirebaseAuth.instance.currentUser!.uid).get()
            : customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
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
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total",
                                            style: TextStyle(fontSize: 20)),
                                        Text(
                                            '${(context.watch<Cart>().totalPrice + 10.0).toString()}',
                                            style: TextStyle(fontSize: 20))
                                      ]),
                                  Divider(
                                      thickness: 2,
                                      color: Colors.grey.shade300),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Total",
                                            style: TextStyle(fontSize: 16)),
                                        Text(
                                            '${(context.watch<Cart>().totalPrice).toString()}',
                                            style: TextStyle(fontSize: 16))
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Shipping Charges",
                                            style: TextStyle(fontSize: 16)),
                                        Text('10.0',
                                            style: TextStyle(fontSize: 16))
                                      ]),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                RadioListTile(
                                    title: Text("Cash on Delievery"),
                                    subtitle: Text("Choose to pay at home"),
                                    value: 1,
                                    groupValue: seletedPaymentOption,
                                    onChanged: (int? value) {
                                      setState(
                                        () {
                                          seletedPaymentOption = value!;
                                        },
                                      );
                                    }),
                                RadioListTile(
                                    title: Text("Pay via visa/master card"),
                                    subtitle: Row(
                                      children: [
                                        Icon(Icons.payment),
                                        Icon(Icons.money)
                                      ],
                                    ),
                                    value: 2,
                                    groupValue: seletedPaymentOption,
                                    onChanged: (int? value) {
                                      setState(
                                        () {
                                          seletedPaymentOption = value!;
                                        },
                                      );
                                    }),
                                RadioListTile(
                                    title: Text("Pay via Paypal"),
                                    subtitle: Row(
                                      children: [
                                        Text("pay with paypal"),
                                        Icon((Icons.money_sharp))
                                      ],
                                    ),
                                    value: 3,
                                    groupValue: seletedPaymentOption,
                                    onChanged: (int? value) {
                                      setState(
                                        () {
                                          seletedPaymentOption = value!;
                                        },
                                      );
                                    })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  bottomSheet: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: () {
                            if (seletedPaymentOption == 1) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Pay at Home ${context.watch<Cart>().totalPrice.toString()}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: TextButton(
                                                onPressed: () async {
                                                  for (var items in context
                                                      .read<Cart>()
                                                      .getItems) {
                                                    CollectionReference
                                                        orderRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'orders');
                                                    String orderId =
                                                        Uuid().v4();
                                                    await orderRef
                                                        .doc(orderId)
                                                        .set({
                                                      'cid': data['cid'],
                                                      'cname': data['name'],
                                                      'email': data['email'],
                                                      'address':
                                                          data['address'],
                                                      'phone': data['phone'],
                                                      'profileimage':
                                                          data['profileimage'],
                                                      'sid': items.suppId,
                                                      'name':items.name,
                                                      'prodid':
                                                          items.documentId,
                                                      'orderid': orderId,
                                                      'orderimage':
                                                          items.imagesUrl[0],
                                                      'orderqty': items.qty,
                                                      'orderprice':
                                                          items.price *
                                                              items.qty,
                                                      'delieverstatus':
                                                          'preparing',
                                                      'delieverydate': "",
                                                      'orderdate':
                                                          DateTime.now(),
                                                      'paymentStatus':
                                                          'pay on delievery',
                                                      'orderreview': false
                                                    }).whenComplete(() async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .runTransaction(
                                                              (transaction) async {
                                                        DocumentReference
                                                            documentRef =
                                                           await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'products')
                                                                .doc(items
                                                                    .documentId);
                                                        DocumentSnapshot
                                                            snapshot2 =
                                                            await transaction
                                                                .get(
                                                                    documentRef);
                                                       await transaction.update(
                                                            documentRef, {
                                                          'quantity': snapshot2[
                                                                  'quantity'] -
                                                              items.qty
                                                        });
                                                      });
                                                    });
                                                  }
                                                  context.read<Cart>().clearCart();
                                                  Navigator.popUntil(context, ModalRoute.withName('/customer_screen'));
                                                },
                                                child: Text(
                                                    'Confirm ${(context.watch<Cart>().totalPrice + 10.0).toString()}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ))),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            } else if (seletedPaymentOption == 2) {
                              print("2");
                            } else {
                              print("3");
                            }
                          },
                          child: Text(
                              'Confirm ${(context.watch<Cart>().totalPrice + 10.0).toString()}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20))),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
