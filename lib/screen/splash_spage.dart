import 'package:flutter/material.dart';
import 'dart:async';

import 'package:restaurantsubthree/screen/home_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash_page';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    splashPageStart();
  }

  splashPageStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.routeName, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 141, 154, 165),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.restaurant,
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              "RESTAURANT TECH",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
