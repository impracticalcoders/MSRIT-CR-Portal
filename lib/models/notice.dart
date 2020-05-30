import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  final Timestamp date;

  final String description;

  final String moreDetailsLink;

  final String title;
  final String id;
  Notice(
    {this.date,
    this.description,
    this.moreDetailsLink,
    this.id,
    this.title,}
  );

  factory Notice.fromJson(dynamic json) {
    return Notice(
      date:json['date'] as Timestamp,
      description:json['description'],
      title:json['title'],
      moreDetailsLink: json['moreDetailsLink'],
      id: json['noticeID']
    );
  }
}
