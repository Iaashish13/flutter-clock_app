// import 'package:flutter/cupertino.dart';

// class AlarmInfo {
//   DateTime alarmDateTime;
//   String? description;
//   bool? isActive;
//   List<Color> gradientColor;
//   AlarmInfo({
//     required this.alarmDateTime,
//     this.description,
//     this.isActive,
//     required this.gradientColor,
//   });
// }
// To parse this JSON data, do
//
//     final alarmInfo = alarmInfoFromJson(jsonString);

import 'dart:convert';

AlarmInfo alarmInfoFromJson(String str) => AlarmInfo.fromJson(json.decode(str));

String alarmInfoToJson(AlarmInfo data) => json.encode(data.toJson());

class AlarmInfo {
  AlarmInfo({
    this.id,
    this.title,
    required this.alarmDateTime,
    required this.isPending,
    required this.gradientColorIndex,
  });

  int? id;
  String? title;
  DateTime alarmDateTime;
  bool isPending;
  int gradientColorIndex;

  factory AlarmInfo.fromJson(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending:
            json["isPending"] == 1 ? true : false, //Learn this using sqflite
        gradientColorIndex: json["gradientColorIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending ? 1 : 0, //used using sqflite
        "gradientColorIndex": gradientColorIndex,
      };
}
