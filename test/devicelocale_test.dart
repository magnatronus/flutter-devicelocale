import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/devicelocale.dart';

main() {
  testWidgets('Can retrieve current country', (WidgetTester tester) async {
    const MethodChannel channel =
        const MethodChannel('uk.spiralarm.flutter/devicelocale');
    channel.setMockMethodCallHandler((MethodCall call) async => 'en_US');

    var widget = FutureBuilder<String?>(
      future: Devicelocale.currentCountry,
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? '',
          textDirection: TextDirection.ltr,
        );
      },
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.text('US'), findsOneWidget);
  });

  testWidgets('Can retrieve current language', (WidgetTester tester) async {
    const MethodChannel channel =
        const MethodChannel('uk.spiralarm.flutter/devicelocale');
    channel.setMockMethodCallHandler((MethodCall call) async => 'en_US');

    var widget = FutureBuilder<String?>(
      future: Devicelocale.currentLanguage,
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? '',
          textDirection: TextDirection.ltr,
        );
      },
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.text('en'), findsOneWidget);
  });
}
