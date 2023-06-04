import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widget/snakbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffold_key =
      GlobalKey<ScaffoldMessengerState>();
  late double prodPrice;
  late int prodQuantity;
  late String prodName;
  late String prodDescription;
  late String prodId;
  bool processing = false;
  dynamic imagepickerError;
  String selectedCategory = 'select category';
  String selectedSubCategory = 'subCategoty';
  List<String> Subcategory = [];
  List<String>? imageUrls = [];

  List<XFile>? imagesList = [];

  Future<void> getImagesUrl() async {
    if (selectedCategory != 'select category' &&
        selectedCategory != 'subCategoty') {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();

        try {
          if (imagesList!.isNotEmpty) {
            setState(() {
              processing = true;
            });
            for (var image in imagesList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrls!.add(value);
                });
              });
            }
          }
        } catch (e) {
          print(e);
        }
      } else {
        MyMessageHandler.snakBar(_scaffold_key, "fill all details");
      }
    } else {
      MyMessageHandler.snakBar(_scaffold_key, "fill select category");
    }
  }

  Future<void> uploadData() async {
    prodId = Uuid().v1();
    await products.doc(prodId).set({
      'prodId': prodId,
      'maincategory': selectedCategory,
      'subcategory': selectedSubCategory,
      'price': prodPrice,
      'quantity': prodQuantity,
      'productname': prodName,
      'productdesc': prodDescription,
      'productimages': imageUrls,
      'sid': FirebaseAuth.instance.currentUser!.uid,
      'discount': 0
    });

    setState(() {
      processing = false;
      _formkey.currentState!.reset();
      selectedCategory = 'select category';
      imageUrls = [];
      Subcategory = [];
    });
  }

  void onUpload() async {
    await getImagesUrl();
    await uploadData();
  }

  void pickProductImagesFromGallery() async {
    try {
      final imagePicker = await ImagePicker()
          .pickMultiImage(maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesList = imagePicker;
      });
    } catch (e) {
      setState(() {
        imagepickerError = e;
      });
      print(imagepickerError);
    }
  }

  Widget previewImages() {
    if (imagesList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imagesList![index].path));
          });
    } else {
      return Center(
          child: Text("No images \n \n not yet picked bcz no images in phone!",
              textAlign: TextAlign.center));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffold_key,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(children: [
                        Container(
                          color: Colors.blueGrey.shade100,
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: imagesList == []
                              ? Center(
                                  child: Text("No images \n \n not yet picked!",
                                      textAlign: TextAlign.center))
                              : previewImages(),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "* Select main category",
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade300,
                                    value: selectedCategory,
                                    items: maincateg
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      if (value == 'selected category') {
                                        setState(() {
                                          Subcategory = [];
                                        });
                                      } else if (value == 'men') {
                                        Subcategory = men;
                                      } else if (value == 'women') {
                                        Subcategory = women;
                                      } else if (value == 'shoes') {
                                        Subcategory = shoes;
                                      } else if (value == 'bags') {
                                        Subcategory = bags;
                                      } else if (value == 'electronics') {
                                        Subcategory = electronics;
                                      } else if (value == 'beauty') {
                                        Subcategory = beauty;
                                      } else if (value == 'kids') {
                                        Subcategory = kids;
                                      } else if (value == 'home & garden') {
                                        Subcategory = homeandgarden;
                                      } else if (value == 'accessories') {
                                        Subcategory = accessories;
                                      }
                                      setState(() {
                                        selectedCategory = value!;
                                        selectedSubCategory = 'subCategoty';
                                      });
                                      print(value);
                                    })
                              ],
                            ),
                            Column(
                              children: [
                                Text("* Select Subcategory",
                                    style: TextStyle(color: Colors.red)),
                                DropdownButton(
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade300,
                                    value: selectedSubCategory,
                                    items: Subcategory.map<
                                        DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSubCategory = value!;
                                      });
                                      print(value);
                                    })
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field can not be empty";
                          } else if (value.isValidatePrice() != true) {
                            return "invalid price";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          prodPrice = double.parse(newValue!);
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: textFormFieldDecoration.copyWith(
                          label: Text("price"),
                          hintText: "Price..\$",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field can not be empty";
                          }
                          if (value.isValidateQuantity() != true) {
                            return "invalid quantity";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          prodQuantity = int.parse(newValue!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormFieldDecoration.copyWith(
                          label: Text("Quantity"),
                          hintText: "enter the quantity",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field can not be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          prodName = newValue!;
                        },
                        maxLines: 3,
                        maxLength: 100,
                        decoration: textFormFieldDecoration.copyWith(
                          label: Text("Product Name"),
                          hintText: "enter product name",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field can not be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          prodDescription = newValue!;
                        },
                        maxLines: 8,
                        maxLength: 800,
                        decoration: textFormFieldDecoration.copyWith(
                          label: Text("description"),
                          hintText: "enter product description",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: imagesList!.isEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        pickProductImagesFromGallery();
                      },
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.photo_album,
                        color: Colors.black,
                      ),
                    )
                  : FloatingActionButton(
                      backgroundColor: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          imagesList = [];
                        });
                      },
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
                    ),
            ),
            FloatingActionButton(
              onPressed: () {
                processing == true ? null : onUpload();
              },
              backgroundColor: Colors.yellow,
              child: processing == true
                  ? CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

var textFormFieldDecoration = InputDecoration(
  label: Text("price"),
  hintText: "Price..\$",
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow, width: 1.5),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
      borderRadius: BorderRadius.circular(10)),
);

extension QuantityValidator on String {
  bool isValidateQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidatePrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}



// class Solution {
// public:
//     bool squareIsWhite(string coordinates) {
//         int col = (coordinates[0] - 'a') + 1;
//         cout<<col<<edl;

//         if(col%2==0){
//             int row = coordinates[1] - '0';
//             if(row%2==0){
//                 return false;
//             }
//             else{
//                 return true;
//             }

//         }
//         else{
//               int row = coordinates[1] - '0';
//             if(row%2==0){
//                 return true;
//             }
//             else{
//                 return false;
//             }
//         }
//         return true;
//     }
// };