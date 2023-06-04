import 'package:flutter/material.dart';
class AuthMainButton extends StatelessWidget {
  final String authButtonLabel;
  final Function() actionButton;
  const AuthMainButton({
    Key? key, required this.authButtonLabel, required this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Material(borderRadius: BorderRadius.circular(25), color: Colors.purple, child: MaterialButton(minWidth: double.infinity, onPressed: actionButton,child: Text(authButtonLabel,style: const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),)),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;
  const HaveAccount({
    Key? key, required this.haveAccount, required this.actionLabel, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(haveAccount, style: const TextStyle(fontSize: 16,fontStyle: FontStyle.italic),),
      TextButton(onPressed:onPressed, child: Text(actionLabel,style: const TextStyle(color: Colors.purple,fontSize: 20,fontWeight: FontWeight.bold),))
    ],);
  }
}

class HeaderLabel extends StatelessWidget {
  final String label;
  const HeaderLabel({
    Key? key, required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
        Text(label,style: const TextStyle(fontSize: 40),),
        IconButton(onPressed: (){Navigator.pushReplacementNamed(context, '/welcome_screen');}, icon: const Icon(Icons.home_work,size: 40,))
      ],),
    );
  }
}

var textFormDecoration = InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purpleAccent,width: 1),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      focusedBorder: OutlineInputBorder(
                         borderSide: const BorderSide(color: Colors.deepPurpleAccent,width: 2),
                        borderRadius: BorderRadius.circular(25)
                      ) 
                
                    );