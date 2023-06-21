import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../provider/wish_provider.dart';

class productModel extends StatefulWidget {
  final dynamic product;
  productModel({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<productModel> createState() => _productModelState();
}

class _productModelState extends State<productModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      prodList: widget.product,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 250),
                    child:
                        Image(image: NetworkImage(widget.product['productimages'][0])),
                  ),
                ),
                Text(
                  widget.product['productdesc'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.product['price'].toStringAsFixed(2) + (' \$'),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    widget.product['sid'] == FirebaseAuth.instance.currentUser!.uid
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                            ))
                        : IconButton(
                            onPressed: () {
                              context.read<Wish>().getWishItems.any((element) =>
                                      element.documentId ==
                                      widget.product['prodId'])
                                  ? context
                                      .read<Wish>()
                                      .removeThis(widget.product['prodId'])
                                  : context.read<Wish>().addWishitems(
                                      widget.product['productname'],
                                      widget.product['price'],
                                      1,
                                      widget.product['quantity'],
                                      widget.product['productimages'],
                                      widget.product['prodId'],
                                      widget.product['sid']);
                            },
                            icon: context.watch<Wish>().getWishItems.any(
                                    (element) =>
                                        element.documentId ==
                                        widget.product['prodId'])
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.favorite_outline_outlined,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
