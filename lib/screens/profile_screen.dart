import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screen/customers_order.dart';
import 'package:multi_store_app/customer_screen/wishlist.dart';
import 'package:multi_store_app/screens/cart_screen.dart';

import '../widget/alert_dialogue.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.yellow, Colors.brown]),
                ),
              ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    centerTitle: true,
                    elevation: 0,
                    expandedHeight: 130,
                    flexibleSpace:
                        LayoutBuilder(builder: (context, Constraints) {
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: Constraints.biggest.height <= 130 ? 1 : 0,
                          child: const Text("Account"),
                        ),
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.yellow, Colors.brown]),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                     data["profileimage"]==''?NetworkImage(""): NetworkImage(data['profileimage']),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text(
                                 data['name']==''?'guest'.toUpperCase(): data['name'].toUpperCase(),
                                  style: TextStyle(fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                              child: SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: TextButton(
                                    child: const Center(
                                        child: Text(
                                      "Cart",
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 20),
                                    )),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartScreen()));
                                    },
                                  )),
                            ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.yellow),
                              child: SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: TextButton(
                                    child: const Center(
                                        child: Text(
                                      "Order",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                    )),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CustomersOrders()));
                                    },
                                  )),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: TextButton(
                                    child: const Center(
                                        child: Text(
                                      "WishList",
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 19),
                                    )),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Wishlist()));
                                    },
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 150,
                              child: Image(
                                  image: AssetImage('images/inapp/logo.jpg')),
                            ),
                            const ProfileHeaderLabel(
                              label: "Account Info.",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 260,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    RepeatedListTile(
                                      title: "Email Address",
                                      icon: Icons.email,
                                      subTitle: data['email'],
                                    ),
                                    YellowDivider(),
                                    RepeatedListTile(
                                      title: "Phone",
                                      icon: Icons.phone,
                                      subTitle: data['phone'],
                                    ),
                                    YellowDivider(),
                                    RepeatedListTile(
                                      title: "Address",
                                      icon: Icons.location_pin,
                                      subTitle: data['address'],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const ProfileHeaderLabel(label: "Account Setting"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 260,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    RepeatedListTile(
                                      onPressed: () {},
                                      title: "Edit Profile",
                                      icon: Icons.person,
                                    ),
                                    const YellowDivider(),
                                    RepeatedListTile(
                                        title: "Change Password",
                                        icon: Icons.password,
                                        onPressed: () {}),
                                    const YellowDivider(),
                                    RepeatedListTile(
                                        title: "Log out",
                                        icon: Icons.login,
                                        onPressed: () async {
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
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ]),
          );
        }

        return Text("loading");
      },
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  const RepeatedListTile({
    Key? key,
    required this.title,
    this.subTitle = "",
    required this.icon,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  const ProfileHeaderLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 24),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
