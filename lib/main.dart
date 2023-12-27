import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/common/colors.dart';
import 'package:restaurantsubthree/common/text_theme.dart';
import 'package:restaurantsubthree/data/api/api_service.dart';
import 'package:restaurantsubthree/data/db/database_helper.dart';
import 'package:restaurantsubthree/data/models/response/restaurant_response_model.dart';
import 'package:restaurantsubthree/provider/create_review_provider.dart';
import 'package:restaurantsubthree/provider/database_provider.dart';
import 'package:restaurantsubthree/provider/filter_restaurant_provider.dart';
import 'package:restaurantsubthree/provider/get_detail_restaurant_provider.dart';
import 'package:restaurantsubthree/provider/get_restaurant_provider.dart';
import 'package:restaurantsubthree/provider/search_restaurant_provider.dart';
import 'package:restaurantsubthree/screen/detail_restaurant_page.dart';
import 'package:restaurantsubthree/screen/home_page.dart';
import 'package:restaurantsubthree/screen/list_restaurant_page.dart';
import 'package:restaurantsubthree/screen/splash_spage.dart';
import 'package:restaurantsubthree/widget/build_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(secondary: secondaryColor, onPrimary: Colors.black),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            appBarTheme: const AppBarTheme(elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    textStyle: const TextStyle(),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))))),
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (context) => const SplashPage(),
              settings: const RouteSettings(name: '/'),
            );
          }
          if (settings.name == HomePage.routeName) {
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
              settings: const RouteSettings(name: HomePage.routeName),
            );
          }

          if (settings.name == ListRestaurantPage.routeName) {
            return MaterialPageRoute(
              builder: (context) => const ListRestaurantPage(),
              settings: const RouteSettings(name: ListRestaurantPage.routeName),
            );
          }
          if (settings.name == DetailRestaurantPage.routeName) {
            Restaurant restaurant = settings.arguments as Restaurant;
            return Fade(
              page: DetailRestaurantPage(
                restaurant: restaurant,
              ),
              settings: RouteSettings(
                  name: '/detailProfilItem', arguments: restaurant),
            );
          }
          return null;
        },
      ),
    );
  }
}
