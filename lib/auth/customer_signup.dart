import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/auth_widget.dart';
import '../widget/snakbar.dart';


class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
   
}

class _CustomerRegisterState extends State<CustomerRegister> {

  late String name;
  late String email;
  late String pass;
  late String profileImage;
 bool passVisible = true;
 bool signUpProgress = false;

 dynamic imagepickerError;
 final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
 final GlobalKey<ScaffoldMessengerState> _scaffold_key= GlobalKey<ScaffoldMessengerState>();
 XFile? _imageFile;
 CollectionReference customers = FirebaseFirestore.instance.collection('customers');
 void _pickImageFromCamera() async{

  try{
     final imagePicker =  await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 300,maxWidth: 300,imageQuality: 95);
    setState(() {
      
      _imageFile = imagePicker;
    });
  }catch(e){
    setState(() {
      imagepickerError =e;
    });
    print(imagepickerError);
  }

 }

 void _pickImageFromGallery() async{

  try{
     final imagePicker =  await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 300,maxWidth: 300,imageQuality: 95);
    setState(() {
      
      _imageFile = imagePicker;
    });
  }catch(e){
    setState(() {
      imagepickerError =e;
    });
    print(imagepickerError);
  }

 }

void signUp()async{
  setState(() {
    signUpProgress = true;
  });
   if(_formKey.currentState!.validate()){
                        if(_imageFile!=null){
                          try{
                             await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
                       
                     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('cust-image/$email.jpg');

                     await ref.putFile(File(_imageFile!.path));

                      profileImage = await ref.getDownloadURL();
                       await customers.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'name':name,
                        'email':email,
                        'profileimage':profileImage,
                        'phone':'',
                        'address':'',
                        'cid':FirebaseAuth.instance.currentUser!.uid
                      });
                       _formKey.currentState!.reset();
                        setState(() {
                           
                          _imageFile=null;
                        });
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/customer_screen');

                          } on FirebaseAuthException catch(e){
                            if(e.code=='weak-password'){
                              setState(() {
                                signUpProgress=false;
                              });
                               MyMessageHandler.snakBar(_scaffold_key,"Weak password");
                            }
                            else if(e.code=='email-already-in-use'){
                               setState(() {
                                signUpProgress=false;
                              });
                               MyMessageHandler.snakBar(_scaffold_key,"Email already exist");
                            }
                          }
                      
                        }
                        else{
                           setState(() {
                                signUpProgress=false;
                              });
                           MyMessageHandler.snakBar(_scaffold_key,"Please select an image");
                        }
                       
                      }
                      else{
                         setState(() {
                                signUpProgress=false;
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
                  child: Column( children: [
                    const HeaderLabel(label: "Sign up",),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.purpleAccent,
                          backgroundImage: _imageFile==null?null:FileImage(File(_imageFile!.path)),
                        ),
                      ),
                      Column(children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                          ),
                          child: IconButton(onPressed: (){
                            _pickImageFromCamera();
                          }, icon: const Icon(Icons.camera_alt)),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                          Container(
                          decoration: const BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                          ),
                          child: IconButton(onPressed: (){
                            _pickImageFromGallery();
                          }, icon: const Icon(Icons.photo)),
                        )
                      ],)
                    ],),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return "please enter your name";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name=value;
                        },
                        decoration:textFormDecoration.copyWith(labelText: "Full name",hintText: "enter your name")
                      ),
                    ),
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
                            return "please enter your pass";
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
                    HaveAccount(haveAccount: "Already have an account",actionLabel: "Log in",onPressed: (){
                      Navigator.pushReplacementNamed(context, '/customer_login');
                    },),
                   signUpProgress?const CircularProgressIndicator(): AuthMainButton(authButtonLabel: "Sign up",actionButton: ()async{
                     signUp();
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

