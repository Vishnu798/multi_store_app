
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../widget/auth_widget.dart';
import '../widget/snakbar.dart';


class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key}) : super(key: key);

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
   
}

class _SupplierLoginState extends State<SupplierLogin> {

  late String name;
  late String email;
  late String pass;
  late String profileImage;
 bool passVisible = true;
 bool logInProgress = false;

 dynamic imagepickerError;
 final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
 final GlobalKey<ScaffoldMessengerState> _scaffold_key= GlobalKey<ScaffoldMessengerState>();



void logIn()async{
  setState(() {
    logInProgress = true;
  });
   if(_formKey.currentState!.validate()){
                        
                          try{
                             await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                       

                   
                       _formKey.currentState!.reset();
                       
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/supplier_screen');

                          } on FirebaseAuthException catch(e){

                              if(e.code=='user-not-found'){
                                setState(() {
                                        logInProgress = false;
                                      });
                                return  MyMessageHandler.snakBar(_scaffold_key,"user not found");
                                
                              }
                              else if(e.code=='wrong-password'){
                                setState(() {
                              logInProgress = false;
                                 });
                                return  MyMessageHandler.snakBar(_scaffold_key,"Wrong password");
                              
                              }
                            
                          }
                      
                        
                       
                       
                      }
                      else{
                         setState(() {
    logInProgress = true;
  });
                      MyMessageHandler.snakBar(_scaffold_key,"Please fill all details");
                       
                        
                      }
}
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffold_key,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const HeaderLabel(label: "Sign up",),
                   
                
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: TextFormField(
                          validator: (value) {
                          if(value!.isEmpty){
                            return "please enter your email";
                          }
                          else if(value.isValidEmail()==false){
                              return "not valid Email";
                          }
                          if(value.isValidEmail()==true){
                            return null;
                          }
                          return null;
                        },
                       onChanged: (value) {
                         email = value;
                       },
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFormDecoration.copyWith(labelText: "Email",hintText: "enter your email")
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: TextFormField(
                          validator: (value) {
                          if(value!.isEmpty){
                            return "please enter your password";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          pass = value;
                        },
                        obscureText: passVisible,
                        decoration: textFormDecoration.copyWith(labelText: "Pass",hintText: "enter your password",suffixIcon: IconButton(onPressed: (){setState(() {
                          passVisible=!passVisible;
                        }); }, icon: Icon(passVisible? Icons.visibility_off:Icons.visibility,color: Colors.purple,)) )
                      ),
                    ),
                    TextButton(onPressed: (){}, child: const Text("forgot Password?",style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),)),
                    HaveAccount(haveAccount: "Don't have an account",actionLabel: "Sign up",onPressed: (){
                      Navigator.pushNamed(context, '/suppliers_sineup');
                    },),
                   logInProgress?const CircularProgressIndicator(): AuthMainButton(authButtonLabel: "Login",actionButton: ()async{
                     logIn();
                    },)
                  ],),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String{
  bool isValidEmail(){
    return RegExp(r'[a-zA-Z0-9]+[\.\_\-]*[@][a-zA-Z0-9]{2,}[\.][a-zA-z]{2,3}$').hasMatch(this);
  }
}

