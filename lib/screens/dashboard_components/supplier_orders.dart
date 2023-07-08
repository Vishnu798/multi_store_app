import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/screens/dashboard_components/supplier_orders_components/preparing.dart';

class SuppliersOrders extends StatelessWidget {
  const SuppliersOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const AppBarTitle(subCategName: "Orders"),
        bottom: TabBar(tabs: [
          Text("orders"),
          Text("Shipping"),
          Text("Delieverd")
        ]),
        ),
        body: TabBarView(children: [
          Preparing(),
          Center(child: Text("shipping")),
          Center(child: Text("Delievered"))
        ]),
      ),
    );
  }
}