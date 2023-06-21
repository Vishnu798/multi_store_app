import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/minor_screen/visit_store.dart';
import 'package:multi_store_app/screens/dashboard_components/edit_business.dart';
import 'package:multi_store_app/screens/dashboard_components/manage_products.dart';
import 'dart:core';

import 'package:multi_store_app/screens/dashboard_components/my_store.dart';
import 'package:multi_store_app/screens/dashboard_components/statics.dart';
import 'package:multi_store_app/screens/dashboard_components/supplier_balance.dart';
import 'package:multi_store_app/screens/dashboard_components/supplier_orders.dart';
import 'package:multi_store_app/widget/alert_dialogue.dart';

List<String> label = [
  "My Store",
  "Orders",
  "Edit profile",
  "Manage Products",
  "Balance",
  "Statics"
];
List<IconData> icon = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart
];
List navigate = [
   VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SuppliersOrders(),
  const EditBusiness(),
  const ManageProducts(),
  const Balance(),
  const Statics()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(subCategName: "Dashboard"),
        actions: [
          IconButton(
              onPressed: () async{
                AlertMessage.myAlertMessage(
                                              context: context,
                                              title: "Sign Out",
                                              content:
                                                  "Do you want to sign out?",
                                              tapNo: () {
                                                Navigator.pop(context);
                                              },
                                              tapyes: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.pop(context);
                                                Navigator.pushReplacementNamed(
                                                    context, '/welcome_screen');
                                              });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,
            children: List.generate(6, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => navigate[index]));
                },
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.purpleAccent.shade200,
                  color: Colors.blueGrey.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icon[index],
                        color: Colors.yellowAccent,
                        size: 50,
                      ),
                      Center(
                          child: Text(
                        label[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      )),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
