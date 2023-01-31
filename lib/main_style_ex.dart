import 'package:bocco_emo_simulation/l10n/l10n.dart';
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
    return MaterialApp(
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
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      body: Center(
        child: Text(l10n!.hello),
      ),
    );
  }
}
