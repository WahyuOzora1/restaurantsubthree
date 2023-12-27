import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/screen/detail_restaurant_page.dart';

Widget buildRestaurantOne(BuildContext context, Restaurant restaurant) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, DetailRestaurantPage.routeName,
          arguments: restaurant);
    },
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: "restaurantOne-${restaurant.pictureId}",
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(restaurant.city),
                      ],
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildRestaurantTwo(BuildContext context, Restaurant restaurant) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, DetailRestaurantPage.routeName,
          arguments: restaurant);
    },
    child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Hero(
                tag: "restaurantTwo-${restaurant.pictureId}",
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"))),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              restaurant.city,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Flexible(
                            child: RatingBar.builder(
                              initialRating: restaurant.rating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 12,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                              tapOnlyMode: true,
                              ignoreGestures: true,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        )),
  );
}
