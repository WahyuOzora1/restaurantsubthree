// To parse this JSON data, do
//
//     final searchRestaurantRespondModel = searchRestaurantRespondModelFromJson(jsonString);

import 'dart:convert';

import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';

SearchRestaurantRespondModel searchRestaurantRespondModelFromJson(String str) =>
    SearchRestaurantRespondModel.fromJson(json.decode(str));

String searchRestaurantRespondModelToJson(SearchRestaurantRespondModel data) =>
    json.encode(data.toJson());

class SearchRestaurantRespondModel {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchRestaurantRespondModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantRespondModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantRespondModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}



// class Restaurant {
//   final String id;
//   final String name;
//   final String description;
//   final String pictureId;
//   final String city;
//   final double rating;

//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.pictureId,
//     required this.city,
//     required this.rating,
//   });

//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         pictureId: json["pictureId"],
//         city: json["city"],
//         rating: json["rating"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "pictureId": pictureId,
//         "city": city,
//         "rating": rating,
//       };
// }
