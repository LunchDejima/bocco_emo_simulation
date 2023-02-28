import 'package:bocco_emo_simulation/etc/style.dart';
import 'package:bocco_emo_simulation/l10n/l10n.dart';
import 'package:bocco_emo_simulation/router/router.dart';
import 'package:bocco_emo_simulation/screens/search_repository_screen.dart';
import 'package:bocco_emo_simulation/view_model/search_repo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchRepoModel>(create: (context) => SearchRepoModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: getTheme(const Style(colorSheme: ColorScheme.light())),
      darkTheme: getTheme(const Style(colorSheme: ColorScheme.dark())),
      routeInformationParser: AppRouteInformationPareser(),
      routerDelegate: AppRouterDelegate(pagesBuilder: ((state) {
        return [
          const MaterialPage(child: SearchRepoScreen()),

        ];
      })),
    );
  }
}
