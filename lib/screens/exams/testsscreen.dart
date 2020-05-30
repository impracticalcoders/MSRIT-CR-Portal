import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crportal/components/examcard.dart';
import 'package:crportal/models/exam.dart';
import 'package:crportal/screens/exams/addexam.dart';
import 'package:flutter/material.dart';

class TestsScreen extends StatefulWidget {
  final String classcode;
  TestsScreen({Key key, this.classcode}) : super(key: key);

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('classCodes')
              .document(widget.classcode)
              .collection("tests")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Exam> currentTests = snapshot.data.documents
                  .map((doc) => Exam.fromJson(doc))
                  .toList();

              if (currentTests.length == 0)
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.change_history,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        'No exams pending',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              currentTests
                  .sort((a, b) => a.date.compareTo(b.date));
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index >= currentTests.length) return null;

                  return ExamCard(
                    exam: currentTests[index],
                    classcode: widget.classcode,
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add_circle_outline),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new AddExam(
                  classcode: widget.classcode,
                );
              },
              fullscreenDialog: true));
        },
      ),
    );
  }
}
