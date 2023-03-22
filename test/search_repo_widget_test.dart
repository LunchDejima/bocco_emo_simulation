import 'package:bocco_emo_simulation/main_search_repository.dart';
import 'package:bocco_emo_simulation/view_model/search_repo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('search repo test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchRepoModel>(
              create: (context) => SearchRepoModel()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.byKey(const Key('search_repo')), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Flutter');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bt_search')));
    await tester.pumpAndSettle();
    expect(find.text('flutter'), findsOneWidget);
    // await tester.tap(find.byType(ListTile));
    // await tester.pumpAndSettle();

    // expect(find.byKey(const Key('SRepoDetail')), findsOneWidget);
    // expect(find.byKey(const Key('repoName')), findsOneWidget);
  });
}
