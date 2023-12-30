import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/provider/preferences_provider.dart';
import 'package:restaurantsubthree/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Restaurant Notification'),
                  subtitle: const Text('Enable Notification'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isRestaurantNewsActive,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurants(value);
                          provider.enableDailyNews(value);
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Restaurant Camp'),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Restaurant Camp'),
                              content: SingleChildScrollView(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color:
                                      const Color.fromARGB(255, 160, 171, 180),
                                  child: Lottie.asset(
                                      'assets/jsons/lottie_animation.json'),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.restaurant)),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
