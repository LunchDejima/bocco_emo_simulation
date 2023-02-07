import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  setUrlStrategy(PathUrlStrategy()); //FIXME: ignore # from path.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: const String.fromEnvironment('APP_NAME'),
      routeInformationParser: const _RouteInformationParser(),
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(title: const Text('Main')),
                body: Center(
                  child: ElevatedButton(
                    child: const Text('Next Page'),
                    onPressed: () {
                      _routerState.change(Uri(path: '/nextpage'));
                    },
                  ),
                ),
              ),
            ),
            if (state.path.contains('nextpage'))
              MaterialPage(
                child: Scaffold(
                  appBar: AppBar(title: const Text('Next Page')),
                  body: Center(
                    child: ElevatedButton(
                      child: const Text('Back to Main'),
                      onPressed: () {
                        _routerState.change(Uri(path: '/'));
                      },
                    ),
                  ),
                ),
              ),
          ];
          print(pages);
          return pages;
        },
      ),
    );
  }
}

final _routerState = _RouterState();

class _RouterState with ChangeNotifier {
  Uri _state = Uri(path: '/');
  Uri get state => _state;

  void change(Uri value) {
    _state = value;
    notifyListeners();
  }

  void pop() {
    final p = _state.path.split('/');
    p.removeLast();
    change(Uri(path: p.join('/')));
  }
}

class _RouteInformationParser extends RouteInformationParser<Uri> {
  const _RouteInformationParser() : super();

  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    Uri uri = Uri.parse(routeInformation.location!);
    return uri;
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    return RouteInformation(location: configuration.path);
  }
}

class _RouterDelegate extends RouterDelegate<Uri> with PopNavigatorRouterDelegateMixin {
  final List<Page> Function(Uri state) pageBuilder;
  final _RouterState routerState;

   _RouterDelegate({required this.pageBuilder, required this.routerState});

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void addListener(VoidCallback listener) {
    routerState.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    routerState.removeListener(listener);
  }

  @override
  Uri? get currentConfiguration {
    return routerState.state;
  }

  @override
  Future<void> setNewRoutePath(Uri configuration) async {
    routerState.change(configuration);
  }

  @override
  Future<void> setRestoredRoutePath(Uri configuration) {
    return super.setRestoredRoutePath(configuration);
  }

  @override
  Widget build(BuildContext context) {
    final pages = pageBuilder(currentConfiguration!);
    if (pages.isEmpty) {
      pages.add(const MaterialPage(child: Scaffold()));
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        routerState.pop();
        return route.didPop(result);
      },
    );
  }
}