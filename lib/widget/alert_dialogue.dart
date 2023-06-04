import 'package:flutter/cupertino.dart';

class AlertMessage{
  static void myAlertMessage({required BuildContext context,required String title,required String content,required void Function() tapNo,required void Function() tapyes}){
     showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  Text(title),
        content:  Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            
            isDefaultAction: true,
            onPressed: 
              tapNo,
              
            
            child: const Text('No'),
          ),
          CupertinoDialogAction(
           
            isDestructiveAction: true,
            onPressed:  tapyes,
             
              
            
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  } 
}