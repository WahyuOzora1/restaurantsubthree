import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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

      when(client.post(Uri.parse('https://restaurant-api.dicoding.dev/review'),
              body: customerReview.toJson()))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","customerReviews":[{"name":"Widdy","review":"Tidak ada duanya!","date":"13 Juli 2019"},{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"Gilang","review":"Saya sangat suka menu malamnya!","date":"13 Juli 2019"},{"name":"Anonymous","review":"test","date":"29 Desember 2023"},{"name":"Anonymous","review":"test","date":"29 Desember 2023"},{"name":"Dono","review":"Keren Sekali","date":"29 Desember 2023"},{"name":"Dono","review":"Keren Sekali","date":"29 Desember 2023"}]}',
              201));

      final result =
          await ApiService().postReviewRestaurant(customerReview, client);

      expect(result, true);
    });
  });
}
