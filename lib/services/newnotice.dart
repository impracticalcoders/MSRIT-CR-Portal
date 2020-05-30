import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

Future<int> addNoticeToDB({String title,String description,DateTime date,String classcode,String moreDetailsLink}) async{
   
  int statusCode =1;
  
  FirebaseUser user = await getUser();

  //create a new user
  Map<String,dynamic> noticeDetails = new Map();
  

  var uuid = Uuid();
  var noticeID = uuid.v1();
  noticeDetails.addAll({
    'title':title,
    'description':description,
    'date':date,
  });
  
  await Firestore.instance.collection('classCodes').document(classcode).collection('notices').document(noticeID).setData(noticeDetails).catchError((onError){statusCode =3;});

  return statusCode;
}

Future<FirebaseUser> getUser()async{
  return await FirebaseAuth.instance.currentUser();
}
