import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/place_order_screen.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/models/cart_model.dart';
import 'package:multi_store_app/provider/product_cart.dart';
import 'package:multi_store_app/screens/customer_home.dart';
import 'package:multi_store_app/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/wish_provider.dart';

class CartScreen extends StatefulWidget {
  final Widget? backButton;
  CartScreen({Key? key, required this.backButton}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: widget.backButton,
            title: const AppBarTitle(subCategName: "Cart"),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<Cart>().clearCart();
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.black,
                  ))
            ],
          ),
          body: context.watch<Cart>().getItems.isNotEmpty? 
           Consumer<Cart>(
            builder: (context, cart, child) {
              return ListView.builder(    
                  itemCount: cart.count,
                  itemBuilder: (context, index) {
                    final product = cart.getItems[index];
                    return CartModel(product: product,cart: context.read<Cart>(),);
                  });
            },
          ):
           Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Your Cart is Empty!",style: TextStyle(fontSize: 25),),
              const SizedBox(height:50),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlueAccent,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width*0.6,
                  onPressed: () {
                    Navigator.canPop(context)?Navigator.pop(context):
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerHomeScreen() ,));
                },child: const Text("Continue Shopping"),),
              )
            ],),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                  children: [
                    Text("Total: \$",style: TextStyle(fontSize: 18),),
                    Text(
                      context.watch<Cart>().totalPrice.toStringAsFixed(2),
                      style: TextStyle(color: Colors.red,fontSize: 18),
                    ),
                  ],
                ),
                Material(
                    color: Colors.yellow,
                    child: MaterialButton(
                      onPressed:context.watch<Cart>().totalPrice==0.0?null: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceOrderScreen()));
                      },
                      child: const Text("Check Out"),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showActionSheet(BuildContext context,void cart, final prodList) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Remove Item'),
        message: const Text('Are you sure you want to remove'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            
            onPressed: () {
              context.read<Wish>().getWishItems.any((element) =>
                                      element.documentId ==
                                      prodList['prodId'])
                                  ? context
                                      .read<Wish>()
                                      .removeThis(prodList['prodId'])
                                  : context.read<Wish>().addWishitems(
                                      prodList['productname'],
                                      prodList['price'],
                                      1,
                                      prodList['quantity'],
                                      prodList['productimages'],
                                      prodList['prodId'],
                                      prodList['sid']);
                                      context
                                      .read<Wish>()
                                      .removeThis(prodList['prodId']);
            },
            child: const Text('Move to wishlist'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
             cart;
            },
            child: const Text('Action'),
          ),
         
        ],
      ),
    );
  }
}

