import 'package:flutter/material.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imageList;
  const FullScreenView({Key? key, required this.imageList}) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back))
      ),
      body: Column(children: [
        Center(child: Text("${index} / 5",style: TextStyle(fontSize: 30,wordSpacing: 8),)),
        SizedBox(height:MediaQuery.of(context).size.height*0.5,child:PageView(
          onPageChanged: (value) {
            setState(() {
              index=value;
            });
          },
          controller: _controller,
          children: 
          List.generate(widget.imageList.length, (index){
           return InteractiveViewer(
            transformationController: TransformationController(),
            child: Image(image: NetworkImage(widget.imageList[index].toString()),));
          })
        ,)),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
          child: ListView.builder(itemCount: widget.imageList.length,
          scrollDirection: Axis.horizontal,
           itemBuilder: (context,index){
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(index);
              },
              child: Container(
                // TODO add box decoration
                margin: EdgeInsets.all(8),
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 4,color: Colors.yellow),
                  borderRadius: BorderRadius.circular(10)
                ),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.imageList[index],fit: BoxFit.cover,))),
            );
          }),
        )
      ],),
    );
  }
}