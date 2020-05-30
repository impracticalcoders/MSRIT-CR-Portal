import 'package:crportal/models/notice.dart';
import 'package:flutter/material.dart';

class NoticeCard extends StatelessWidget {
  final Notice notice;
  
  NoticeCard(
      {this.notice,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: ListTile(
                  title: Text(
                    notice.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      notice.date.toDate().toString(),),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                     /* Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => IndividualOrderPage(
                                    orderData: order,
                                    distance: dist,
                                    user: user,
                                    orderid: orderid,
                                  )));*/
                    },
                  ),
                  isThreeLine: true,
                  onTap: () {
                   /* Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => IndividualOrderPage(
                                  orderData: order,
                                  distance: dist,
                                  user: user,
                                  orderid: orderid,
                                )));*/
                  },
                )));
  }
}
