import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';

Widget buildRestaurantCategory(BuildContext context, Category category) {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(color: Colors.blue[50]),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ),
  );
}
