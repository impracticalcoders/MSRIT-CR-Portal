import 'package:crportal/models/exam.dart';
import 'package:crportal/screens/exams/individualexamscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  
  final String classcode;
  
  ExamCard(
      {this.exam,
      this.classcode = 'NA',
      });

   String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Hero(tag:exam.examID,child:
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: ListTile(
                  title: Text(
                    exam.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'On '+_formatDate(exam.date.toDate()),),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                     Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => IndividualExamPage(
                                   exam: exam,
                                  )));
                    },
                  ),
                  //isThreeLine: true,
                  onTap: () {
                   Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => IndividualExamPage(
                                   exam: exam,
                                   classcode: classcode,
                                  )));
                  },
                ))));
  }
}
