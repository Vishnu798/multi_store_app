import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/sub_categ_products.dart';
import 'package:multi_store_app/screens/customer_home.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const AppBarTitle(subCategName: "Cart"),
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_outlined,color: Colors.black,))
              ],
          ),
          body: Center(
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
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
              const Row(
                children: [
                  Text("Total: \$"),
                    Text("00:00",style:TextStyle(color: Colors.red),),
                ],
              ),
            
              Material(
                color: Colors.yellow,
                child: MaterialButton(onPressed: (){},child: const Text("Check Out"),))
            ],),
          ),
        ),
      ),
    );
  }
}