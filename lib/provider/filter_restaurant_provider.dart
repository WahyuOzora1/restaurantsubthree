import 'package:flutter/material.dart';

enum FilterOptions { semua, ratingTerbaik }

class FilterProvider with ChangeNotifier {
  FilterOptions _filter = FilterOptions.semua;

  FilterOptions get filter => _filter;

  void setFilter(FilterOptions newFilter) {
    _filter = newFilter;
    notifyListeners();
  }
}
