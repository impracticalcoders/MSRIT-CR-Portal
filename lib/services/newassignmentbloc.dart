import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

Future<int> addAssignmentToDB(String title,String subjcode,String description,DateTime deadline,String submissionurl,String moredetailsurl,String classcode) async{
   
  int statusCode =1;
  
  FirebaseUser user = await getUser();

  //create a new user
  Map<String,dynamic> assignmentDetails = new Map();
  

  var uuid = Uuid();
  var assignmentId = uuid.v1();
  assignmentDetails.addAll({
    'title':title,
    'description':description,
    'deadline':deadline,
    'moreDetailsLink':moredetailsurl,
    'submitLink':submissionurl,
    'subjectCode':subjcode,
  });
  
  await Firestore.instance.collection('classCode').document('CS2B').collection('assignment').document(assignmentId).setData(assignmentDetails).catchError((onError){statusCode =3;});

  return statusCode;
}

Future<FirebaseUser> getUser()async{
  return await FirebaseAuth.instance.currentUser();
}
