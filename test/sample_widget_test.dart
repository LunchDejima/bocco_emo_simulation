// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bocco_emo_simulation/etc/style.dart';
import 'package:bocco_emo_simulation/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bocco_emo_simulation/main.dart';

void main() {
  testWidgets('Main Widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byKey(const Key('main')), findsOneWidget);

    await tester.tap(find.byKey(const Key('bt_next_page')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('next_page')), findsOneWidget);
    expect(find.text('Back to Main'), findsOneWidget);
  });

  testWidgets('NextPage Widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    routerState.change(Uri(path: '/nextpage'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('next_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('bt_back_to_main')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('main')), findsOneWidget);
  });

  testWidgets('NextPage Widget with Mock', (WidgetTester tester) async {
    await tester.pumpWidget(const MockMaterialApp(widget: NextPage()));
    expect(find.byKey(const Key('next_page')), findsOneWidget);
  });
}

class MockMaterialApp extends StatelessWidget {
  final Widget widget;
  const MockMaterialApp({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(Style.light),
      darkTheme: getTheme(Style.dark),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      home: widget,
    );
  }
}
