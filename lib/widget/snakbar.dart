import 'package:flutter/material.dart';

class MyMessageHandler{
   static void snakBar(var _scaffold_key, String message){
    _scaffold_key.currentState!.hideCurrentSnackBar();
    _scaffold_key.currentState!.showSnackBar(SnackBar(
                          backgroundColor: Colors.yellow,
                          duration: const Duration(seconds: 2),
                          content: Text(message,style: const TextStyle(fontSize: 18,color: Colors.black),
                          ),
                        ));
  }
}