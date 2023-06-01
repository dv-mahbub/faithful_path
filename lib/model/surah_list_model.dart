// To parse this JSON data, do
//
//     final surahListModel = surahListModelFromJson(jsonString);

import 'dart:convert';

SurahListModel surahListModelFromJson(String str) => SurahListModel.fromJson(json.decode(str));

String surahListModelToJson(SurahListModel data) => json.encode(data.toJson());

class SurahListModel {
  int code;
  String status;
  List<Datum> data;

  SurahListModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory SurahListModel.fromJson(Map<String, dynamic> json) => SurahListModel(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  String revelationType;

  Datum({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    numberOfAyahs: json["numberOfAyahs"],
    revelationType: json["revelationType"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "numberOfAyahs": numberOfAyahs,
    "revelationType": revelationType,
  };
}

