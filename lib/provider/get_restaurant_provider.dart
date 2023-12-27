import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantRespondModel _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantRespondModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Please make sure your connection internet!';
    }
  }
}
