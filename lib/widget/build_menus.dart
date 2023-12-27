import 'package:flutter/material.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';

Widget buildRestaurantFood(BuildContext context, Food food) {
  return GestureDetector(
    onTap: () {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("${food.name}, Yummy!!!")));
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          food.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ),
  );
}

Widget buildRestaurantDrink(BuildContext context, Drink drink) {
  return GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${drink.name}, Yummy!!!")));
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          drink.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ),
  );
}
