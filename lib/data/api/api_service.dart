import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantsubthree/data/models/request/customer_review_request.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/data/models/response/search_restaurant_response_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantRespondModel> getRestaurants(http.Client client) async {
    final response = await client.get(Uri.parse("${_baseUrl}list"));
    try {
      if (response.statusCode == 200) {
        return RestaurantRespondModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RestaurantDetailRespondModel> getRestaurantsDetail(
      String id, http.Client client) async {
    final response = await client.get(Uri.parse("${_baseUrl}detail/$id"));
    try {
      if (response.statusCode == 200) {
        return RestaurantDetailRespondModel.fromJson(
            json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurant');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SearchRestaurantRespondModel> searchRestaurants(String param) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$param"));
    try {
      if (response.statusCode == 200) {
        return SearchRestaurantRespondModel.fromJson(
            json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> postReviewRestaurant(
      CustomerReviewRequest customerReview, http.Client client) async {
    try {
      final response = await client.post(
        Uri.parse("${_baseUrl}review"),
        body: customerReview.toJson(),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
