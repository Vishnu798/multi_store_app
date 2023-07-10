import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

class SupplierPreparingOrder extends StatelessWidget {
  final order;
  const SupplierPreparingOrder({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            borderRadius: BorderRadius.circular(25)),
        child: ExpansionTile(
          title: Row(
            children: [
              Container(
                constraints:
                    BoxConstraints(maxHeight: 40, maxWidth: double.infinity),
                child: Image.network(order['orderimage']),
              ),
              Flexible(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("see more..."), Text(order['delieverstatus'])]),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Name :  ${order['cname']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Phone :  ${order['phone']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Email :  ${order['email']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Address :  ${order['address']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Mode of Payment :  ${order['paymentStatus']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Delievery Status :  ${order['delieverstatus']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        'Date : ${DateFormat('yyyy-MM-dd').format(order['orderdate'].toDate()).toString()}'),
                  ),
                  order['delieverstatus'] == 'delievered'
                      ? Text(
                          "This orders has been delievered",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        )
                      : Row(
                          children: [
                            Text(
                              "change delievery status to :",
                              style: TextStyle(fontSize: 16),
                            ),
                            order['delieverstatus'] == 'preparing'
                                ? TextButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context);
                                    },
                                    child: Text('shipping?'))
                                : TextButton(
                                    onPressed: () {},
                                    child: Text('Delievered?'))
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
