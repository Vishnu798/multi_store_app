import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product_cart.dart';
import '../provider/wish_provider.dart';

class CartModel extends StatelessWidget {
  final Cart cart;
  const CartModel({
    Key? key,
    required this.product, required this.cart,
  }) : super(key: key);

  final Product product;

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
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                             product.qty==1? IconButton(
                                  onPressed: () {
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
                      product.documentId)
                  ? cart.removeItem(product)
                     
                  : context.read<Wish>().addWishitems(
                      product.name,
                      product.price,
                      1,
                      product.qty,
                      product.imagesUrl,
                      product.documentId,
                      product.suppId);
                     cart.removeItem(product);
                      Navigator.pop(context);
            },
            child: const Text('Move to wishlist'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
             cart.removeItem(product);
             Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
         
        ],
        cancelButton: TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("cancel")),
      ),
    );
                                  },
                                  icon: Icon(
                                      Icons.delete_forever_outlined)): IconButton(
                                  onPressed: () {
                                    cart.decrement(product);
                                  },
                                  icon: Icon(
                                      Icons.minimize)),
                              Text(
                                product.qty.toString(),
                                style: TextStyle(
                                    color:product.qntty==product.qty?Colors.red:Colors.grey.shade600,
                                    fontSize: 20,
                                    fontFamily: 'Acme'),
                              ),
                              IconButton(
                                  onPressed: () {
                                   product.qntty==product.qty?null:cart.increment(product);
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                        )
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