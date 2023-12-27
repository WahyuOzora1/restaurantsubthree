import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/common/navigation.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/provider/database_provider.dart';
import 'package:restaurantsubthree/screen/detail_restaurant_page.dart';

class ListFavoritepage extends StatefulWidget {
  static const routeName = '/list_favorite_page';
  const ListFavoritepage({super.key});

  @override
  State<ListFavoritepage> createState() => _ListFavoritepageState();
}

class _ListFavoritepageState extends State<ListFavoritepage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                _buildSearchBar(),
                _buildFavoriteRestaurant()
              ])),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          Provider.of<DatabaseProvider>(context, listen: false)
              .filterFavoriteRestaurants(query);
        },
        decoration: const InputDecoration(
          labelText: 'Search Favorite Restaurants',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildFavoriteRestaurant() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      List<Restaurant> listFavoriteRestaurants =
          provider.filteredFavoriteRestaurants.isNotEmpty
              ? provider.filteredFavoriteRestaurants
              : provider.restaurants;

      if (provider.state == ResultFavoriteState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (provider.state == ResultFavoriteState.hasData) {
        if (provider.filteredFavoriteRestaurants.isEmpty &&
            _searchController.text.isNotEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 250),
            child: Center(
              child: Text('No matching restaurants found.'),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listFavoriteRestaurants.length,
            itemBuilder: (context, index) {
              final Restaurant favoriteRestaurant =
                  listFavoriteRestaurants[index];
              return GestureDetector(
                onTap: () => Navigation.intentWithData(
                    DetailRestaurantPage.routeName, favoriteRestaurant),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Hero(
                          tag: "restaurantTwo-${favoriteRestaurant.pictureId}",
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://restaurant-api.dicoding.dev/images/small/${favoriteRestaurant.pictureId}",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Flexible(
                                    child: Text(
                                      favoriteRestaurant.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 16),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          favoriteRestaurant.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RatingBar.builder(
                                          initialRating:
                                              favoriteRestaurant.rating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 12,
                                          itemBuilder: (context, _) =>
                                              const Icon(
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
                                        favoriteRestaurant.rating.toString(),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else if (provider.state == ResultFavoriteState.noData) {
        return Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(
            child: Text(provider.message),
          ),
        );
      } else if (provider.state == ResultFavoriteState.error) {
        return Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(
            child: Text(provider.message),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
