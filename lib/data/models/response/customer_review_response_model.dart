// To parse this JSON data, do
//
//     final customerReviewRespondModel = customerReviewRespondModelFromJson(jsonString);

import 'dart:convert';

CustomerReviewRespondModel customerReviewRespondModelFromJson(String str) =>
    CustomerReviewRespondModel.fromJson(json.decode(str));

String customerReviewRespondModelToJson(CustomerReviewRespondModel data) =>
    json.encode(data.toJson());

class CustomerReviewRespondModel {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  CustomerReviewRespondModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerReviewRespondModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewRespondModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}
