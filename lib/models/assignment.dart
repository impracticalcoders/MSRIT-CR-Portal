import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final Timestamp deadline;

  final String description;

  final String moreDetailsLink;

  final String subjectCode;

  final String submitLink;

  final String title;

  final String AssignmentID;

  Assignment(
    this.deadline,
    this.description,
    this.moreDetailsLink,
    this.subjectCode,
    this.submitLink,
    this.title,
    this.AssignmentID,
  );

  factory Assignment.fromJson(dynamic json) {
    return Assignment(
      json['deadline'] as Timestamp,
      json['description'],
      json['moreDetailsLink'],
      json['subjectCode'],
      json['submitLink'],
      json['title'],
      json['assignmentID'],
    );
  }
}
