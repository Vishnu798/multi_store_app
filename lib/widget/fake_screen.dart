import 'package:flutter/material.dart';

import '../minor_screen/search.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(border: Border.all(color: Colors.amber,width: 1.4),borderRadius: BorderRadius.circular(25)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:  [
          const Icon(Icons.search,color: Colors.grey,),
          const Text("What are you looking for",style: TextStyle(color: Colors.grey,fontSize: 16),),
          Container(
            height: 32,
            width: 75,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.amber),
            child: const Center(child: Text("Search",style: TextStyle(color: Colors.white),)),
          ),
        ],
          
        ),
      ),
    );
  }
}