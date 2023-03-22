import 'package:bocco_emo_simulation/api/bocco_api_client.dart';
import 'package:bocco_emo_simulation/etc/style.dart';
import 'package:bocco_emo_simulation/router/router.dart';
import 'package:bocco_emo_simulation/screens/repo_detail_screen.dart';
import 'package:bocco_emo_simulation/screens/search_repository_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return MaterialApp.router(
      theme: getTheme(const Style(colorSheme: ColorScheme.light())),
      darkTheme: getTheme(const Style(colorSheme: ColorScheme.dark())),
      routeInformationParser: SearchRepoRouteInformationPareser(),
      routerDelegate: AppRouterDelegate(pagesBuilder: ((state) {
        return [
          MaterialPage(child: Scaffold())
        ];
      })),
    );
  }
}
