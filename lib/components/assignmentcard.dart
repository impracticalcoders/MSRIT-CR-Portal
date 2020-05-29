import 'package:crportal/models/assignment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final String orderid;
  
  AssignmentCard(
      {this.assignment,
      this.orderid = '0',
      });

   String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: ListTile(
                  title: Text(
                    assignment.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Due '+_formatDate(assignment.deadline.toDate()),),
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
