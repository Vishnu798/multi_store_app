import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/auth/suppliers_sineup.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool progress = false;
   CollectionReference customers = FirebaseFirestore.instance.collection('customers');

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
    _controller.repeat();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/inapp/bgimage.jpg'),
          fit: BoxFit.cover,
        )),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              const SizedBox(
                height: 120,
                width: 240,
                child: Image(image: AssetImage('images/inapp/logo.jpg')),
              ),
              const Text(
                "Shop",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Suppliers Only",
                    style: TextStyle(color: Colors.yellowAccent, fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50))),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AnimatedWidget(controller: _controller),
                        Material(
                          color: Colors.yellow,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/supplier_login');
                            },
                            child: const Text("Log in"),
                          ),
                        ),
                        Material(
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SuppliersRegister()));
                              },
                              child: const Text("Sign in"),
                            ))
                      ],
                    ),
                  )),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          color: Colors.yellow,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerRegister()));
                            },
                            child: const Text("Sign in"),
                          ),
                        ),
                        Material(
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/customer_login');
                              },
                              child: const Text("login in"),
                            )),
                        AnimatedWidget(controller: _controller),
                      ],
                    ),
                  )),
              Container(
                decoration: const BoxDecoration(color: Colors.white54),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GoogleFacebookLogin(
                      label: "Google",
                      child: const Image(
                          image: AssetImage('images/inapp/google.jpg')),
                      onPressed: () {},
                    ),
                    GoogleFacebookLogin(
                        label: "Facebook",
                        onPressed: () {},
                        child: const Image(
                            image: AssetImage('images/inapp/facebook.jpg'))),
                    progress
                        ? const CircularProgressIndicator()
                        : GoogleFacebookLogin(
                            label: "Guest",
                            onPressed: () async {
                              await FirebaseAuth.instance.signInAnonymously().whenComplete(()async{
                                await customers.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'name':'',
                        'email':'',
                        'profileimage':'',
                        'phone':'',
                        'address':'',
                        'cid':FirebaseAuth.instance.currentUser!.uid
                      });
                              });
                              setState(() {
                                progress = true;
                              });
                              Navigator.pushReplacementNamed(
                                  context, '/customer_screen');
                            },
                            child: const Icon(
                              Icons.person,
                              color: Colors.lightBlueAccent,
                              size: 50,
                            ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedWidget extends StatelessWidget {
  const AnimatedWidget({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller.view,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: child,
          );
        },
        child: const Image(image: AssetImage('images/inapp/logo.jpg')));
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  const GoogleFacebookLogin({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.child,
  }) : super(key: key);
  final String label;
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: child,
            ),
            Text(label)
          ],
        ),
      ),
    );
  }
}
