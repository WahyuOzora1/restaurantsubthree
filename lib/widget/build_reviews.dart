import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';

Widget buildRestaurantReview(BuildContext context, CustomerReview review) {
  return Card(
    elevation: 4.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  review.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Flexible(
                child: Text(
                  review.date,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            review.review,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}
