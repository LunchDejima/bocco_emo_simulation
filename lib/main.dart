import 'package:bocco_emo_simulation/l10n/l10n.dart';
import 'package:bocco_emo_simulation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: const String.fromEnvironment('APP_NAME'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        late Locale _locale;
        if (locale == null) {
          _locale = supportedLocales.first;
        } else {
          final _l = Locale(locale.languageCode);
          _locale = supportedLocales.contains(_l) ? _l : supportedLocales.first;
        }
        // FIXME: start initialize
        Intl.defaultLocale = _locale.toString();
        return _locale;
      },
      routeInformationParser: AppRouteInformationPareser(),
      routerDelegate: AppRouterDelegate(pagesBuilder: ((state) {
        return [
          MaterialPage(
            child: Scaffold(
              key: const Key('main'),
              body: Center(
                child: TextButton(
                    key: const Key('bt_next_page'),
                    child: const Text('next page →'),
                    onPressed: () {
                      routerState.change(Uri(path: '/nextpage'));
                    }),
              ),
            ),
          ),
          if (routerState.state.path.contains('nextpage'))
            const MaterialPage(child: NextPage())
        ];
      })),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('next_page'),
      body: Center(
        child: TextButton(
          key: const Key('bt_back_to_main'),
          onPressed: () {
            routerState.pop();
          },
          child: const Text('Back to Main'),
        ),
      ),
    );
  }
}