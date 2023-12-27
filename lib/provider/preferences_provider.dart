import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  bool _isRestaurantNewsActive = false;
  bool get isRestaurantNewsActive => _isRestaurantNewsActive;

  void _getDailyRestaurantPreferences() async {
    _isRestaurantNewsActive = await preferencesHelper.isDailyRestaurantsActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantPreferences();
  }
}
