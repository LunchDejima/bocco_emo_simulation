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
      routeInformationParser: _RouteInformationPareser(),
      routerDelegate: _RouterDelegate(pagesBuilder: ((state) {
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

final routerState = _RouteState();

class _RouteInformationPareser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    Uri uri = Uri.parse(routeInformation.location!);
    if (uri.path.isEmpty) {
      uri = Uri(path: '/');
    }
    return uri;
  }

  @override
  RouteInformation? restoreRouteInformation(Uri configuration) {
    return RouteInformation(location: configuration.path);
  }
}

class _RouteState extends ChangeNotifier {
  Uri _state = Uri(path: '/');
  Uri get state => _state;

  void change(Uri newUri) {
    _state = newUri;
    notifyListeners();
  }

  void pop() {
    final path = routerState.state.path.split('/');
    path.removeLast();
    change(Uri(path: path.join('/').isEmpty ? '/' : path.join('/')));
  }
}

class _RouterDelegate extends RouterDelegate<Uri>
    with PopNavigatorRouterDelegateMixin<Uri> {
  final List<Page> Function(Uri state) pagesBuilder;

  _RouterDelegate({required this.pagesBuilder});

  @override
  void addListener(VoidCallback listener) {
    routerState.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final pages = pagesBuilder(currentConfiguration!);

    return Navigator(
      pages: pages,
      onPopPage: (route, result) {
        routerState.pop();
        return route.didPop(result);
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Uri? get currentConfiguration => routerState.state;

  @override
  void removeListener(VoidCallback listener) {
    routerState.removeListener(listener);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    routerState.change(Uri(path: configuration.path));
  }
}
