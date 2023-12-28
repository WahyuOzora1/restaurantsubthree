import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';
import 'package:http/http.dart' as http;

enum ResultDetailState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  late String idRestaurant;
  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetailRespondModel _detailRestaurantResult;
  late ResultDetailState _state = ResultDetailState.loading;
  String _message = '';

  String get message => _message;

  RestaurantDetailRespondModel get result => _detailRestaurantResult;

  ResultDetailState get state => _state;

  Future<dynamic> fetchdetailRestaurant(String id) async {
    try {
      _state = ResultDetailState.loading;
      notifyListeners();
      final detailRestaurant =
          await apiService.getRestaurantsDetail(id, http.Client());
      if (detailRestaurant.restaurant.id == "") {
        _state = ResultDetailState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultDetailState.hasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = ResultDetailState.error;
      notifyListeners();
      return _message = 'Please make sure your connection internet!';
    }
  }
}
