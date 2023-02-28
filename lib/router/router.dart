import 'package:flutter/material.dart';


final routerState = AppRouteState();

class AppRouteState extends ChangeNotifier {
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

class AppRouteInformationPareser extends RouteInformationParser<Uri> {
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

class AppRouterDelegate extends RouterDelegate<Uri>
    with PopNavigatorRouterDelegateMixin<Uri> {
  final List<Page> Function(Uri state) pagesBuilder;

  AppRouterDelegate({required this.pagesBuilder});

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