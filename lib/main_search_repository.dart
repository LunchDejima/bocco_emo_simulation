import 'package:bocco_emo_simulation/etc/style.dart';
import 'package:bocco_emo_simulation/router/router.dart';
import 'package:bocco_emo_simulation/screens/repo_detail_screen.dart';
import 'package:bocco_emo_simulation/screens/search_repository_screen.dart';
import 'package:bocco_emo_simulation/view_model/search_repo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchRepoModel>(
            create: (context) => SearchRepoModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: getTheme(const Style(colorSheme: ColorScheme.light())),
      darkTheme: getTheme(const Style(colorSheme: ColorScheme.dark())),
      routeInformationParser: SearchRepoRouteInformationPareser(),
      routerDelegate: AppRouterDelegate(pagesBuilder: ((state) {
        return [
          const MaterialPage(child: SearchRepoScreen()),
          if (state.path.contains('detail_repo'))
            const MaterialPage(child: RepositoryDetailScreen())
        ];
      })),
    );
  }
}
