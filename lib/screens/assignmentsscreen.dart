import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crportal/components/assignmentcard.dart';
import 'package:crportal/models/assignment.dart';
import 'package:crportal/screens/addassignment.dart';
import 'package:flutter/material.dart';

class AssignmentsScreen extends StatefulWidget {
  final String classcode;
  AssignmentsScreen({Key key, this.classcode}) : super(key: key);

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('classCodes')
                  .document(widget.classcode)
                  .collection("assignments")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Assignment> currentAssignments = snapshot.data.documents
                      .map((doc) => Assignment.fromJson(doc))
                      .toList();

                  if (currentAssignments.length == 0)
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.list,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            'No assignments pending',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  currentAssignments
                      .sort((a, b) => a.deadline.compareTo(b.deadline));
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= currentAssignments.length) return null;
                     
                        return AssignmentCard(assignment: currentAssignments[index],classcode: widget.classcode,);
                      
                    },
                  );
                } 
                
                else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add_circle_outline),
        onPressed: (){
Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new AddAssignment(classcode: widget.classcode,);
      },
    fullscreenDialog: true
  ));

        },
      ),
    );
  }
}
