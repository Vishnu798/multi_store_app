import 'package:flutter/material.dart';

class MyOrder extends StatelessWidget {
  final order;
  const MyOrder({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.yellow),borderRadius: BorderRadius.circular(25)),
                      child: ExpansionTile(
                          title: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: 80, maxWidth: double.infinity),
                            child: Image.network(order['orderimage']),
                          ),
                          Flexible(
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(
                                children: [
                                  Text(
                                    order['name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(order['orderprice'].toString()),
                                  Text(order['orderqty'].toString())
                                ],
                              )
                            ]),
                          ),
                     
                        ],
                      ),
                      subtitle:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                            Text("see more"),
                            Text(order['delieverstatus'])

                          ]
                          ),
                          children: [
                            Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text('Name :  ${order['cname']}',style: TextStyle(fontSize: 16),),
                              Text('Phone :  ${order['phone']}',style: TextStyle(fontSize: 16),),
                              Text('Email :  ${order['email']}',style: TextStyle(fontSize: 16),),
                              Text('Address :  ${order['address']}',style: TextStyle(fontSize: 16),),
                              Text('Mode of Payment :  ${order['paymentStatus']}',style: TextStyle(fontSize: 16),),
                              Text('Delievery Status :  ${order['delieverstatus']}',style: TextStyle(fontSize: 16),),
                              Text('Estimate Delievery Date :  ${order['delieverydate']}',style: TextStyle(fontSize: 16),),

                             order['delieverstatus']=='delieverd' && order['orderreview']==false?TextButton(onPressed: (){}, child: Text("Give review")):Container(height: 0,),
                             
                            order['delieverstatus']=='delieverd' && order['orderreview']==true?  Row(children: [
                              Icon(Icons.check),
                              Text("Review added")
                             ],):Container(height:0)                            ],),
                            )
                          ],
                      ),
                    ),
                  );
  }
}