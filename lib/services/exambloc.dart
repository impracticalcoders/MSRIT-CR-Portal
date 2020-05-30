import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

Future<int> addExamToDB(String title,String subjcode,String description,DateTime deadline,String moredetailsurl,String classcode) async{
   
  int statusCode =1;
  
  FirebaseUser user = await getUser();

  //create a new user
  Map<String,dynamic> examDetails = new Map();
  

  var uuid = Uuid();
  var examId = uuid.v1();
  examDetails.addAll({
    'title':title,
    'description':description,
    'date':deadline,
    'moreDetailsLink':moredetailsurl,
    'subjectCode':subjcode,
    'testID':examId
  });
  
  await Firestore.instance.collection('classCodes').document(classcode).collection('tests').document(examId).setData(examDetails).catchError((onError){statusCode =3;});

  return statusCode;
}

Future<int> editExaminDB(String examId,{String title,String subjcode,String description,DateTime deadline,String moredetailsurl,String classcode}) async{
   
  int statusCode =1;
  
  

  
  Map<String,dynamic> examDetails = new Map();
  

  
  
  examDetails.addAll({
    'title':title,
    'description':description,
    'date':deadline,
    'moreDetailsLink':moredetailsurl,
    'subjectCode':subjcode,
  
  });
  
  await Firestore.instance.collection('classCodes').document(classcode).collection('tests').document(examId).updateData(examDetails).catchError((onError){statusCode =3;print(onError);});

  return statusCode;
}

Future<int> deleteExamfromDB(String examId,{String classcode}) async{
   
  int statusCode =1;
  print(classcode);
  print("Attempting Delete");
  await Firestore.instance.collection('classCodes').document(classcode).collection('tests').document(examId).delete().catchError((onError){statusCode =3;print(onError);});

  return statusCode;
}

Future<FirebaseUser> getUser()async{
  return await FirebaseAuth.instance.currentUser();
}
