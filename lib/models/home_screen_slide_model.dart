import 'dart:convert';

// HOME SCREEN SLIDE

List<HomeScreenSlideModel> homeScreenSlideModelFromJson(String str) =>
    List<HomeScreenSlideModel>.from(
        json.decode(str).map((x) => HomeScreenSlideModel.fromJson(x)));

String homeScreenSlideModelToJson(List<HomeScreenSlideModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeScreenSlideModel {
  HomeScreenSlideModel({
    required this.img_url,
    this.qr_url,
    required this.id,
  });

  String img_url;
  String? qr_url;
  int id;

  factory HomeScreenSlideModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenSlideModel(
        img_url: json["img_url"],
        qr_url: json["qr_url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "img_url": img_url,
        "qr_url": qr_url,
        "id": id,
      };
}
