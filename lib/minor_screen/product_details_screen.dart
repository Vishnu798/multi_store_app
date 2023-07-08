import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/minor_screen/full_screen_view.dart';
import 'package:multi_store_app/minor_screen/visit_store.dart';
import 'package:multi_store_app/screens/cart_screen.dart';
import 'package:multi_store_app/widget/snakbar.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:badges/badges.dart' as badges;
import '../models/product_model.dart';
import '../provider/cart_provider.dart';
import '../provider/wish_provider.dart';

class ProductDetails extends StatefulWidget {
  final dynamic prodList;
  const ProductDetails({Key? key, this.prodList}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldMessengerState> _scaffold_key =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincategory', isEqualTo: widget.prodList['maincategory'])
        .where('subcategory', isEqualTo: widget.prodList['subcategory'])
        .snapshots();

    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffold_key,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenView(
                                      imageList:
                                          widget.prodList['productimages'])));
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                              pagination: SwiperPagination(
                                  builder: SwiperPagination.fraction),
                              itemBuilder: (context, index) {
                                return Image(
                                  image: NetworkImage(
                                      widget.prodList['productimages'][index]),
                                );
                              },
                              itemCount:
                                  widget.prodList['productimages'].length),
                        ),
                      ),
                      Positioned(
                          left: 15,
                          top: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back,
                                    color: Colors.black)),
                          )),
                      Positioned(
                          right: 15,
                          top: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share, color: Colors.black)),
                          ))
                    ]),
                    Text(
                      widget.prodList['productname'],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'USD',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Text(widget.prodList['price'].toString(),
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<Wish>().getWishItems.any((element) =>
                                      element.documentId ==
                                      widget.prodList['prodId'])
                                  ? context
                                      .read<Wish>()
                                      .removeThis(widget.prodList['prodId'])
                                  : context.read<Wish>().addWishitems(
                                      widget.prodList['productname'],
                                      widget.prodList['price'],
                                      1,
                                      widget.prodList['quantity'],
                                      widget.prodList['productimages'],
                                      widget.prodList['prodId'],
                                      widget.prodList['sid']);
                            },
                            icon: context.watch<Wish>().getWishItems.any(
                                    (element) =>
                                        element.documentId ==
                                        widget.prodList['prodId'])
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
                    ),
                    Text(widget.prodList['quantity']==0?"Out of stock":
                      '${widget.prodList['quantity']} pieces available in stock',
                      style: TextStyle(
                          fontSize: 16, color: Colors.blueGrey.shade400),
                    ),
                    ProductDetailsHeader(
                      label: 'Item Description',
                    ),
                    Text(
                      widget.prodList['productdesc'],
                      style: TextStyle(
                          fontSize: 18, color: Colors.blueGrey.shade800),
                    ),
                    ProductDetailsHeader(
                      label: 'Recommended Items',
                    ),
                    SizedBox(
                        child: StreamBuilder<QuerySnapshot>(
                      stream: _productsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return Text("no category found");
                        }

                        return SingleChildScrollView(
                          child: StaggeredGridView.countBuilder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              itemBuilder: (context, index) {
                                return productModel(
                                    product: snapshot.data!.docs[index]);
                              },
                              staggeredTileBuilder: (context) =>
                                  StaggeredTile.fit(1)),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ),
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VisitStore(suppId: widget.prodList['sid'])));
                    },
                    icon: Icon(Icons.shop)),
                badges.Badge(
                  badgeContent: Text(context.watch<Cart>().count.toString()),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen(
                                      backButton: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.black,
                                          )),
                                    )));
                      },
                      icon: Icon(Icons.shopping_cart_checkout_outlined)),
                ),
                TextButton(
                    onPressed: widget.prodList['quantity']==0?null:() {
                      context.read<Cart>().getItems.any((element) =>
                              element.documentId == widget.prodList['prodId'])
                          ? MyMessageHandler.snakBar(
                              _scaffold_key, "Already added to cart")
                          : context.read<Cart>().additems(
                              widget.prodList['productname'],
                              widget.prodList['price'],
                              1,
                              widget.prodList['quantity'],
                              widget.prodList['productimages'],
                              widget.prodList['prodId'],
                              widget.prodList['sid']);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: widget.prodList['quantity']==0?Color.fromARGB(255, 248, 237, 142):Colors.yellow,),
                      child: Center(
                          child: Text(
                        "Add to cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsHeader extends StatelessWidget {
  final String label;
  const ProductDetailsHeader({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.yellow.shade900, fontSize: 24),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
