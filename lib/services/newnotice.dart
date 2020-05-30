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
    'noticeID':noticeID
  });
  
  await Firestore.instance.collection('classCodes').document(classcode).collection('notices').document(noticeID).setData(noticeDetails).catchError((onError){statusCode =3;});

  return statusCode;
}

Future<int> editNoticeInDB({String noticeID,String title,String description,DateTime date,String moredetailsurl,String classcode}) async{
   
  int statusCode =1;
  
  

  
  Map<String,dynamic> noticeDetails = new Map();
  

  
  
  noticeDetails.addAll({
    'title':title,
    'description':description,
    'date':date,
    'moreDetailsLink':moredetailsurl,
  
  });
  
  await Firestore.instance.collection('classCodes').document(classcode).collection('notices').document(noticeID).updateData(noticeDetails).catchError((onError){statusCode =3;print(onError);});

  return statusCode;
}

Future<int> deleteNoticefromDB({String noticeID,String classcode}) async{
   
  int statusCode =1;
  // print(classcode);
  print("Attempting Delete");
  await Firestore.instance.collection('classCodes').document(classcode).collection('notices').document(noticeID).delete().catchError((onError){statusCode =3;print(onError);});

  return statusCode;
}

Future<FirebaseUser> getUser()async{
  return await FirebaseAuth.instance.currentUser();
}
