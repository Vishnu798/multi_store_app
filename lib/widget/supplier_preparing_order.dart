import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SupplierPreparingOrder extends StatelessWidget {
  final order;
  const SupplierPreparingOrder({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.yellow),borderRadius: BorderRadius.circular(25)),
                      child: ExpansionTile(
                          title: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: 40, maxWidth: double.infinity),
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
                            Text("see more..."),
                            Text(order['delieverstatus'])

                          ]
                          ),
                          children: [
                            Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Name :  ${order['cname']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Phone :  ${order['phone']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Email :  ${order['email']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Address :  ${order['address']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Mode of Payment :  ${order['paymentStatus']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Delievery Status :  ${order['delieverstatus']}',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Order Date : ${order['orderdate'].toString()}",style: TextStyle(fontSize: 16),),
                              ),
                              Text(DateFormat('yyyy-MM-dd').format(order['orderdate'].toDate()).toString())

                            //  order['delieverstatus']=='delieverd' && order['orderreview']==false?TextButton(onPressed: (){}, child: Text("Give review")):Container(height: 0,),
                             
                            // order['delieverstatus']=='delieverd' && order['orderreview']==true?  Row(children: [
                            //   Icon(Icons.check),
                            //   Text("Review added")
                            //  ],):Container(height:0)         
                                                ],),
                            )
                          ],
                      ),
                    ),
                  );
  }
}