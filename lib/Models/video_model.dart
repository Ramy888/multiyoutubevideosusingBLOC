import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoModel {
  String? itemId;
  String? itemNameEn;
  String? itemNameAr;
  String? itemDescEn;
  String? itemDescAr;
  String? itemUrl;
  String? middleBannerUrl;
  String? itemDateTime;  // Keeping as String to match your specification

  VideoModel({
    this.itemId,
    this.itemNameEn,
    this.itemNameAr,
    this.itemDescEn,
    this.itemDescAr,
    this.itemUrl,
    this.middleBannerUrl,
    this.itemDateTime,
  });

  VideoModel.empty()
      : itemId = '',
        itemNameEn = '',
        itemNameAr = '',
        itemDescEn = '',
        itemDescAr = '',
        itemUrl = '',
        middleBannerUrl = '',
        itemDateTime = '';

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    String? videoId = YoutubePlayer.convertUrlToId(json['itemPhotoUrl']);
    return VideoModel(
      itemId: json['itemId'].toString(),
      itemNameEn: json['itemTitle'],               // English title
      itemNameAr: json['itemTitle_ar'],            // Arabic title
      itemDescEn: json['itemDescription'],         // English description
      itemDescAr: json['itemDescription_ar'],      // Arabic description
      itemUrl: videoId,
      middleBannerUrl: json['middleBannerUrl'],    // Assuming this field needs handling or has no JSON equivalent
      itemDateTime: json['created_at'],            // Assuming created_at maps to itemDateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemTitle': itemNameEn,
      'itemTitle_ar': itemNameAr,
      'itemDescription': itemDescEn,
      'itemDescription_ar': itemDescAr,
      'itemPhotoUrl': itemUrl,
      'middleBannerUrl': middleBannerUrl,
      'created_at': itemDateTime,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemNameEn': itemNameEn,
      'itemNameAr': itemNameAr,
      'itemDescEn': itemDescEn,
      'itemDescAr': itemDescAr,
      'itemUrl': itemUrl,
      'middleBannerUrl': middleBannerUrl,
      'itemDateTime': itemDateTime,
    };
  }

  // Convert Map to HomePageModel
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      itemId: map['itemId'],
      itemNameEn: map['itemNameEn'],
      itemNameAr: map['itemNameAr'],
      itemDescEn: map['itemDescEn'],
      itemDescAr: map['itemDescAr'],
      itemUrl: map['itemUrl'],
      middleBannerUrl: map['middleBannerUrl'],
      itemDateTime: map['itemDateTime'],
    );
  }
}