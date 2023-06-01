// To parse this JSON data, do
//
//     final hadithListModel = hadithListModelFromJson(jsonString);

import 'dart:convert';

List<HadithListModel> hadithListModelFromJson(String str) => List<HadithListModel>.from(json.decode(str).map((x) => HadithListModel.fromJson(x)));

String hadithListModelToJson(List<HadithListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HadithListModel {
  String hadithEnglish;
  String hadithArabic;
  String hadithBengali;
  String checkStatus;
  String hadithNo;
  String id;
  String thesequence;
  String isActive;
  String chapterId;
  String bookId;
  String publisherId;
  String sectionId;
  String statusId;
  String topicName;
  String rabiNameBn;
  String rabiNameEn;

  HadithListModel({
    required this.hadithEnglish,
    required this.hadithArabic,
    required this.hadithBengali,
    required this.checkStatus,
    required this.hadithNo,
    required this.id,
    required this.thesequence,
    required this.isActive,
    required this.chapterId,
    required this.bookId,
    required this.publisherId,
    required this.sectionId,
    required this.statusId,
    required this.topicName,
    required this.rabiNameBn,
    required this.rabiNameEn,
  });

  factory HadithListModel.fromJson(Map<String, dynamic> json) => HadithListModel(
    hadithEnglish: json["hadithEnglish"],
    hadithArabic: json["hadithArabic"],
    hadithBengali: json["hadithBengali"],
    checkStatus: json["checkStatus"],
    hadithNo: json["hadithNo"],
    id: json["id"],
    thesequence: json["thesequence"],
    isActive: json["isActive"],
    chapterId: json["chapterId"],
    bookId: json["bookId"],
    publisherId: json["publisherId"],
    sectionId: json["sectionId"],
    statusId: json["statusId"],
    topicName: json["topicName"],
    rabiNameBn: json["rabiNameBn"],
    rabiNameEn: json["rabiNameEn"],
  );

  Map<String, dynamic> toJson() => {
    "hadithEnglish": hadithEnglish,
    "hadithArabic": hadithArabic,
    "hadithBengali": hadithBengali,
    "checkStatus": checkStatus,
    "hadithNo": hadithNo,
    "id": id,
    "thesequence": thesequence,
    "isActive": isActive,
    "chapterId": chapterId,
    "bookId": bookId,
    "publisherId": publisherId,
    "sectionId": sectionId,
    "statusId": statusId,
    "topicName": topicName,
    "rabiNameBn": rabiNameBn,
    "rabiNameEn": rabiNameEn,
  };
}
