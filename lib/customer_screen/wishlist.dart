import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/provider/product_cart.dart';
import 'package:multi_store_app/screens/customer_home.dart';
import 'package:provider/provider.dart';

import '../models/wish_list_model.dart';
import '../provider/cart_provider.dart';
import '../provider/wish_provider.dart';
import '../widget/snakbar.dart';

class Wishlist extends StatefulWidget {
  final Widget? backButton;
  Wishlist({Key? key, required this.backButton}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final GlobalKey<ScaffoldMessengerState> _scaffold_key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key:_scaffold_key,
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: widget.backButton,
              title: const AppBarTitle(subCategName: "Wishlist"),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       context.read<Cart>().clearCart();
                //     },
                //     icon: const Icon(
                //       Icons.delete_forever_outlined,
                //       color: Colors.black,
                //     ))
              ],
            ),
            body: context.watch<Wish>().getWishItems.isNotEmpty? 
             Consumer<Wish>(
              builder: (context, wish, child) {
                return ListView.builder(
                    itemCount: wish.count,
                    itemBuilder: (context, index) {
                      final product = wish.getWishItems[index];
                      return WishlistModel(product: product, scaffold_key: _scaffold_key);
                    });
              },
            ):
             Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Your Cart is Empty!",style: TextStyle(fontSize: 25),),
               
              
              ],),
            ),
            
          ),
        ),
      ),
    );
  }
}


