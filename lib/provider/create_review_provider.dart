import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/models/request/customer_review_request.dart';
import 'package:http/http.dart' as http;

enum ResultReviewState { firstState, loading, success, error }

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewProvider({required this.apiService});

  ResultReviewState _state = ResultReviewState.firstState;
  String message = '';

  ResultReviewState get state => _state;

  Future<bool> createReview(CustomerReviewRequest param) async {
    try {
      _state = ResultReviewState.loading;
      notifyListeners();

      bool isPost = await apiService.postReviewRestaurant(param, http.Client());

      if (isPost) {
        _state = ResultReviewState.success;
        notifyListeners();
        return true;
      } else {
        _state = ResultReviewState.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _state = ResultReviewState.error;
      notifyListeners();
      return false;
    }
  }
}
