import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';

class Statics extends StatelessWidget {
  const Statics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(subCategName: "Statics"),),
    );
  }
}