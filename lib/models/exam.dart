import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final Timestamp date;

  final String description;

  final String moreDetailsLink;

  final String subjectCode;

  final String title;

  final String examID;

  Exam(
    this.date,
    this.description,
    this.moreDetailsLink,
    this.subjectCode,
    this.title,
    this.examID,
  );

  factory Exam.fromJson(dynamic json) {
    return Exam(
      json['date'] as Timestamp,
      json['description'],
      json['moreDetailsLink'],
      json['subjectCode'],
      json['title'],
      json['testID'],
    );
  }
}
