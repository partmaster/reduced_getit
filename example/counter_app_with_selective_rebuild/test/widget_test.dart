import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:counter_app_with_selective_rebuild/widgets.dart';
import 'package:reduced_getit/reduced_getit.dart';

extension SingleWidgetByType on CommonFinders {
  T singleWidgetByType<T>(Type type) =>
      find.byType(type).evaluate().single.widget as T;
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final registration = registerState(MyAppState(title: ''));

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    await unregisterState(registration);
  });

  testWidgets('selective rebuild test', (tester) async {
    final registration = registerState(MyAppState(title: ''));
    await tester.pumpWidget(const MyApp());

    final homePage0 = find.singleWidgetByType(MyHomePage);
    final counterWidget0 = find.singleWidgetByType(MyCounterWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    final homePage1 = find.singleWidgetByType(MyHomePage);
    final counterWidget1 = find.singleWidgetByType(MyCounterWidget);

    // Verify that counterWidget was rebuild but homePage not.
    expect(identical(homePage0, homePage1), isTrue);
    expect(identical(counterWidget0, counterWidget1), isFalse);

    await unregisterState(registration);
  });
}
