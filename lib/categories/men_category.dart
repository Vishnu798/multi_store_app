import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widget/cate_widgets.dart';

class MenCategory extends StatelessWidget {
  const MenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Positioned(
        bottom: 0,
        left: 0, 
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          width: MediaQuery.of(context).size.width*0.75,
        //  color: Colors.black,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const CateHeaderLabel(headerName: "Men" ,),
            SizedBox (
             // color: Colors.amber,
              height: MediaQuery.of(context).size.height*0.68,
              child: GridView.count(mainAxisSpacing: 70,crossAxisSpacing: 15, crossAxisCount: 3,children: 
               List.generate(men.length-1, (index) {
                return SubCateModel(mainCategName: "men",subCategName: men[index+1],subCategLabel: men[index+1],assestName:"images/men/men$index.jpg");
               })
              ,),
            )
          ],),
        ),
        
      ),
      const Positioned(
        bottom: 0,
        right: 0,
        child: SliderBar())
      ]
    );
  }
}

