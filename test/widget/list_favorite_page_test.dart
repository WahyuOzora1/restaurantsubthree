import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/data/preferences/preferences_helper.dart';
import 'package:restaurantsubthree/provider/preferences_provider.dart';
import 'package:restaurantsubthree/provider/scheduling_provider.dart';
import 'package:restaurantsubthree/screen/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('SettingsPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => PreferencesProvider(
                    preferencesHelper: PreferencesHelper(
                        sharedPreferences: SharedPreferences.getInstance()))),
            ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ],
          child: const SettingsPage(),
        ),
      ),
    );

    expect(find.text(SettingsPage.settingsTitle), findsOneWidget);
    expect(find.text('Restaurant Notification'), findsOneWidget);
    expect(find.text('Enable Notification'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();
  });
}
