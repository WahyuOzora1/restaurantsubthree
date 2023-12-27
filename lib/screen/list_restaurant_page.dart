import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/provider/filter_restaurant_provider.dart';
import 'package:restaurantsubthree/provider/get_restaurant_provider.dart';
import 'package:restaurantsubthree/provider/search_restaurant_provider.dart';
import 'package:restaurantsubthree/widget/build_filter.dart';
import 'package:restaurantsubthree/widget/build_restaurant.dart';

class ListRestaurantPage extends StatefulWidget {
  static const routeName = '/list_restaurant_page';

  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  State<ListRestaurantPage> createState() => _ListRestaurantPageState();
}

class _ListRestaurantPageState extends State<ListRestaurantPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerFilter = Provider.of<FilterProvider>(context, listen: true);
    FilterOptions currentFilter = providerFilter.filter;
    final providerSearch =
        Provider.of<SearchRestaurantProvider>(context, listen: true);
    bool isSearch = providerSearch.isSearch;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Find Your Restaurant',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Recomendation of Ours',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    height: 200.0,
                    child: Consumer<RestaurantProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultState.loading) {
                          return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        } else if (state.state == ResultState.hasData) {
                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.result.restaurants.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Restaurant> listRestaurant =
                                  state.result.restaurants;
                              return buildRestaurantOne(
                                  context,
                                  listRestaurant[
                                      listRestaurant.length - 1 - index]);
                            },
                          );
                        } else if (state.state == ResultState.noData) {
                          return Center(
                            child: Material(
                              child: Text(state.message),
                            ),
                          );
                        } else if (state.state == ResultState.error) {
                          return Center(
                            child: Material(
                              child: Text(state.message),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Material(
                              child: Text(''),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isSearch)
                          const Flexible(
                            child: Text(
                              'All Restaurant',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        if (isSearch)
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                hintText:
                                    'Find your restaurant, category, or menus',
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey[200],
                                focusColor: Colors.amber,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 10.0,
                              ),
                              onChanged: (String value) async {
                                await providerSearch
                                    .fetchSearchRestaurant(value);
                              },
                            ),
                          ),
                        Row(
                          children: [
                            IconButton(
                              icon: isSearch
                                  ? const Icon(Icons.close)
                                  : const Icon(Icons.search),
                              onPressed: () async {
                                if (!isSearch) {
                                  providerSearch.setSeacrh(true);
                                } else {
                                  _searchController.clear();
                                  providerSearch.setSeacrh(false);
                                  providerSearch.setStateSeacrh(
                                      ResultSearchState.firstData);
                                }
                              },
                            ),
                            isSearch
                                ? const SizedBox()
                                : const FilterDropdown(),
                          ],
                        )
                      ],
                    ),
                  ),
                  isSearch
                      ? Consumer<SearchRestaurantProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultSearchState.loading) {
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              );
                            } else if (state.state ==
                                ResultSearchState.hasData) {
                              return ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      state.resultSearch.restaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<Restaurant> listRestaurant =
                                        state.resultSearch.restaurants;

                                    return buildRestaurantTwo(
                                        context, listRestaurant[index]);
                                  });
                            } else if (state.state ==
                                ResultSearchState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else if (state.state == ResultSearchState.error) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else {
                              return Consumer<RestaurantProvider>(
                                builder: (context, state, _) {
                                  if (state.state == ResultState.loading) {
                                    return const Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    );
                                  } else if (state.state ==
                                      ResultState.hasData) {
                                    return ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            state.result.restaurants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          List<Restaurant> listRestaurant =
                                              state.result.restaurants;
                                          List<Restaurant> sortedRestaurants =
                                              List.from(listRestaurant);
                                          sortedRestaurants.sort((a, b) =>
                                              b.rating.compareTo(a.rating));

                                          final Restaurant restaurantMinim =
                                              sortedRestaurants[index];

                                          if (currentFilter ==
                                              FilterOptions.semua) {
                                            return buildRestaurantTwo(
                                                context, listRestaurant[index]);
                                          } else {
                                            return buildRestaurantTwo(
                                                context, restaurantMinim);
                                          }
                                        });
                                  } else if (state.state ==
                                      ResultState.noData) {
                                    return Center(
                                      child: Material(
                                        child: Text(state.message),
                                      ),
                                    );
                                  } else if (state.state == ResultState.error) {
                                    return Center(
                                      child: Material(
                                        child: Text(state.message),
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Material(
                                        child: Text(''),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                        )
                      : Consumer<RestaurantProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.loading) {
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              );
                            } else if (state.state == ResultState.hasData) {
                              return ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.result.restaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<Restaurant> listRestaurant =
                                        state.result.restaurants;
                                    List<Restaurant> sortedRestaurants =
                                        List.from(listRestaurant);
                                    sortedRestaurants.sort(
                                        (a, b) => b.rating.compareTo(a.rating));

                                    final Restaurant restaurantMinim =
                                        sortedRestaurants[index];

                                    if (currentFilter == FilterOptions.semua) {
                                      return buildRestaurantTwo(
                                          context, listRestaurant[index]);
                                    } else {
                                      return buildRestaurantTwo(
                                          context, restaurantMinim);
                                    }
                                  });
                            } else if (state.state == ResultState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else if (state.state == ResultState.error) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Material(
                                  child: Text(''),
                                ),
                              );
                            }
                          },
                        ),
                ],
              ),
            )),
      ),
    );
  }
}
