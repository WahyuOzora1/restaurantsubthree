import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/db/database_helper.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';

enum ResultFavoriteState { firstState, loading, hasData, noData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavoriterestaurants();
  }

  ResultFavoriteState _state = ResultFavoriteState.firstState;
  ResultFavoriteState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  List<Restaurant> _filteredFavoriteRestaurants = [];

  List<Restaurant> get filteredFavoriteRestaurants =>
      _filteredFavoriteRestaurants;

  void filterFavoriteRestaurants(String query) {
    _filteredFavoriteRestaurants = _restaurants
        .where((restaurant) =>
            restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
            restaurant.city.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void _getFavoriterestaurants() async {
    _state = ResultFavoriteState.loading;
    _restaurants = await databaseHelper.getRestaurants();
    if (_restaurants.isNotEmpty) {
      _state = ResultFavoriteState.hasData;
    } else {
      _state = ResultFavoriteState.noData;
      _message = 'Empty Favorite Restaurants';
    }
    notifyListeners();
  }

  void addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getFavoriterestaurants();
    } catch (e) {
      _state = ResultFavoriteState.error;
      _message = 'Please make sure your connection internet!';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getFavoriterestaurants();
    } catch (e) {
      _state = ResultFavoriteState.error;
      _message = 'Please make sure your connection internet!';
      notifyListeners();
    }
  }
}
