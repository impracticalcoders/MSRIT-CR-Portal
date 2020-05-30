import 'package:crportal/models/notice.dart';
import 'package:crportal/screens/notice/individualnoticepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeCard extends StatelessWidget {
  final Notice notice;
  final String classcode;

  NoticeCard({
    this.notice,
    this.classcode,
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
                notice.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Dated : ' +
                    _formatDate(notice.date.toDate()) +
                    '\n\n' +
                    notice.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => IndividualNoticePage(
                                notice: notice,
                                classcode: classcode ?? "NA",
                              )));
                },
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => IndividualNoticePage(
                              notice: notice,
                              classcode: classcode ?? "NA",
                            )));
              },
            )));
  }
}
