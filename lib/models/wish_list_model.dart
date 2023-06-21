import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product_cart.dart';
import '../provider/wish_provider.dart';
import '../widget/snakbar.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    Key? key,
    required this.product,
    required GlobalKey<ScaffoldMessengerState> scaffold_key,
  }) : _scaffold_key = scaffold_key, super(key: key);

  final Product product;
  final GlobalKey<ScaffoldMessengerState> _scaffold_key;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
          child: SizedBox(
        height: 100,
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 120,
              child: Image.network(product.imagesUrl[0]),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(2)} \$',
                          style: TextStyle(
                              color: Colors.red, fontSize: 16),
                        ),
                        Row(children: [
                          IconButton(onPressed: (){
                            context.read<Wish>().removeItem(product);
                          }, icon: Icon(Icons.delete_forever)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: (){
                            context.read<Cart>().getItems.any((element) =>
              element.documentId == product.documentId)
          ? MyMessageHandler.snakBar(
              _scaffold_key, "Already added to cart")
          : context.read<Cart>().additems(
              product.name,
              product.price,
              1,
              product.qntty,
              product.imagesUrl,
              product.documentId,
              product.suppId);
                          }, icon: Icon(Icons.add_shopping_cart)),
        
                        ],)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}