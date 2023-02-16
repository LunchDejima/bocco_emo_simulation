import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bocco_emo_simulation/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify the counter starts at 0.
    final finder = find.byKey(const Key('main'));
    expect(finder, findsOneWidget);

    expect(find.byKey(const Key('main')), findsOneWidget);

    await tester.tap(find.byKey(const Key('bt_next_page')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('next_page')), findsOneWidget);
    expect(find.text('Back to Main'), findsOneWidget);

    // TODO: 今の所iosでscreenshotを取ることはできない
    //await binding.takeScreenshot('screenshot_test');
  });
}