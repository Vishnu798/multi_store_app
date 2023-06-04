import 'package:flutter/material.dart';

class SubCategProducts extends StatelessWidget {
  const SubCategProducts({Key? key, required this.subCategName, required this.mainCategName}) : super(key: key);
    final String subCategName;
    final String mainCategName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitle(subCategName: subCategName),),
      body: Center(child: Text(mainCategName)),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.subCategName,
  }) : super(key: key);

  final String subCategName;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(subCategName,style: const TextStyle(fontFamily: 'Acme',color: Colors.black),));
  }
}