import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/models/request/customer_review_request.dart';

import 'post_review_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('postReviewRestaurant', () {
    test(
        'returns true if the http call completes successfully (status code 201)',
        () async {
      final client = MockClient();

      final customerReview = CustomerReviewRequest(
          id: 'w9pga3s2tubkfw1e867', name: 'Dono', review: 'Keren Sekali');

      final result =
          await ApiService().postReviewRestaurant(customerReview, client);

      expect(result, true);
    });
  });
}
