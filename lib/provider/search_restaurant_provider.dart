import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/models/response/search_restaurant_response_model.dart';

enum ResultSearchState { loading, noData, hasData, error, firstData }

class SearchRestaurantProvider with ChangeNotifier {
  final ApiService apiService;

  late SearchRestaurantRespondModel _searchResult;
  late ResultSearchState _state = ResultSearchState.firstData;
  String _message = '';

  SearchRestaurantProvider({required this.apiService});

  String get message => _message;

  SearchRestaurantRespondModel get resultSearch => _searchResult;

  ResultSearchState get state => _state;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  void setSeacrh(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  void setStateSeacrh(ResultSearchState value) {
    _state = value;
    notifyListeners();
  }

  Future<dynamic> fetchSearchRestaurant(String param) async {
    try {
      _state = ResultSearchState.loading;
      notifyListeners();
      final restaurantDataSearch = await apiService.searchRestaurants(param);
      if (restaurantDataSearch.restaurants.isEmpty) {
        _state = ResultSearchState.noData;
        notifyListeners();
        return _message = 'No matching restaurants found.';
      } else {
        _state = ResultSearchState.hasData;
        notifyListeners();
        return _searchResult = restaurantDataSearch;
      }
    } catch (e) {
      _state = ResultSearchState.error;
      notifyListeners();
      return _message = 'Please make sure your connection internet!';
    }
  }
}
