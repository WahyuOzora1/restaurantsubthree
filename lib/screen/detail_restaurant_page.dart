import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurantsubthree/data/models/request/customer_review_request.dart';
import 'package:restaurantsubthree/data/models/response/detail_restaurant_response_mode.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/provider/create_review_provider.dart';
import 'package:restaurantsubthree/provider/database_provider.dart';
import 'package:restaurantsubthree/provider/get_detail_restaurant_provider.dart';
import 'package:restaurantsubthree/widget/build_category.dart';
import 'package:restaurantsubthree/widget/build_menus.dart';
import 'package:restaurantsubthree/widget/build_reviews.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const DetailRestaurantPage({super.key, required this.restaurant});

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<RestaurantDetailProvider>(context, listen: false);
      provider.fetchdetailRestaurant(widget.restaurant.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
        if (state.state == ResultDetailState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (state.state == ResultDetailState.hasData) {
          Restaurant1 detailRestaurant = state.result.restaurant;
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Hero(
                              tag:
                                  "restaurantOne-${detailRestaurant.pictureId}",
                              child: Image.network(
                                "https://restaurant-api.dicoding.dev/images/small/${detailRestaurant.pictureId}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(detailRestaurant.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Consumer<DatabaseProvider>(
                                        builder: (context, provider, child) {
                                      return FutureBuilder<bool>(
                                          future: provider
                                              .isFavorite(widget.restaurant.id),
                                          builder: (context, snapshot) {
                                            var isBookmarked =
                                                snapshot.data ?? false;
                                            return Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors
                                                    .white, // Mengubah warna latar belakang menjadi putih
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: isBookmarked
                                                  ? IconButton(
                                                      icon: const Icon(
                                                          Icons.favorite),
                                                      color: Colors
                                                          .red, // Mengubah warna ikon favorit
                                                      onPressed: () {
                                                        provider.removeFavorite(
                                                            widget
                                                                .restaurant.id);
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: const Icon(Icons
                                                          .favorite_border_outlined),
                                                      // Mengubah warna ikon favorit
                                                      onPressed: () {
                                                        provider
                                                            .addFavoriteRestaurant(
                                                                widget
                                                                    .restaurant);
                                                      },
                                                    ),
                                            );
                                          });
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        const SizedBox(width: 8.0),
                                        Text(detailRestaurant.city),
                                        const Spacer(), // Menggunakan Spacer agar elemen-elemen berada di sisi kanan
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text('${detailRestaurant.rating}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(detailRestaurant.address),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 37,
                                  child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        detailRestaurant.categories.length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        buildRestaurantCategory(context,
                                            detailRestaurant.categories[index]),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Description:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                ReadMoreText(
                                  detailRestaurant.description,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Food Menu:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        detailRestaurant.menus.foods.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            buildRestaurantFood(
                                                context,
                                                detailRestaurant
                                                    .menus.foods[index]),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Drink Menu:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        detailRestaurant.menus.drinks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            buildRestaurantDrink(
                                                context,
                                                detailRestaurant
                                                    .menus.drinks[index]),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Customers Review:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        shape: const CircleBorder(),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          iconSize: 16.0,
                                          onPressed: () {
                                            _showReviewDialog(context);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      detailRestaurant.customerReviews.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          buildRestaurantReview(
                                              context,
                                              detailRestaurant
                                                  .customerReviews[index]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 20,
                    top: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 199, 182, 181)),
                      child: IconButton(
                        icon:
                            const Icon(Icons.keyboard_double_arrow_left_sharp),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )),
              ],
            ),
          );
        } else if (state.state == ResultDetailState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultDetailState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }

  Future<void> _showReviewDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Review'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(labelText: 'Review'),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            Consumer<ReviewProvider>(
              builder: (context, state, _) {
                if (state.state == ResultReviewState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return TextButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String review = reviewController.text;

                    final reviewProvider =
                        Provider.of<ReviewProvider>(context, listen: false);
                    bool isPosted = await reviewProvider.createReview(
                        CustomerReviewRequest(
                            id: widget.restaurant.id,
                            name: name,
                            review: review));

                    if (context.mounted) {
                      if (isPosted) {
                        final provider = Provider.of<RestaurantDetailProvider>(
                            context,
                            listen: false);
                        await provider
                            .fetchdetailRestaurant(widget.restaurant.id);
                      }
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Thanks for your review!")));
                    }
                  },
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
