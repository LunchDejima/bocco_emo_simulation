import 'package:flutter/material.dart';

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
      routeInformationParser: _RouteInformationParser(),
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: ((state) {
          final pages = [
            const MaterialPage(child: MainScreen()),
            if (state.path.contains('home'))
              const MaterialPage(child: HomeScreen()),
            if (state.path.contains('contents'))
              const MaterialPage(child: HomeScreen()),
          ];
          return pages;
        }),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: _RouterDelegate(
          routerState: _routerState,
          pageBuilder: ((state) {
            final pages = [
              if (state.path.contains('home'))
                const MaterialPage(child: HomeScreen()),
              if (state.path.contains('contents'))
                const MaterialPage(child: ContentsScreen()),
            ];
            return pages;
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.list)),
        ],
        onTap: ((value) {
          if (value == 0) {
            _routerState.change(Uri(path: 'main/home'));
          } else if (value == 1) {
            _routerState.change(Uri(path: 'main/contents'));
          }
        }),
      ),
    );
  }
}

class Item {
  final int id;
  final String title;
  const Item(this.id, this.title);
}

const List<Item> contentsList = [
  Item(1, 'item1'),
  Item(2, 'item2'),
  Item(4, 'item3'),
  Item(4, 'item4'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen() : super(key: const Key('home'));

  @override
  Widget build(BuildContext context) {
    final item3 = contentsList[2];

    return Router(
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(title: const Text('Home')),
                body: GestureDetector(
                  onTap: () =>
                      _routerState.change(Uri(path: 'main/contents_detail')),
                  child: Container(
                      padding: EdgeInsets.all(30), child: Text(item3.title)),
                ),
              ),
            ),
          ];
          return pages;
        },
      ),
    );
  }
}

class ContentsScreen extends StatelessWidget {
  const ContentsScreen() : super(key: const Key('contents'));

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            const MaterialPage(child: Scaffold()),
          ];
          return pages;
        },
      ),
    );
  }
}

class ContantsDetailScreen extends StatelessWidget {
  const ContantsDetailScreen() : super(key: const Key('contents_detail'));

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

final _routerState = _RouterState();

class _RouterState with ChangeNotifier {
  Uri _state = Uri(path: '/');
  get state => _state;

  void change(Uri value) {
    _state = value;
    notifyListeners();
  }

  void pop() {
    final splitedPath = _state.path.split('/');
    splitedPath.removeLast();
    change(Uri(path: splitedPath.join('/')));
  }
}

class _RouteInformationParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location!);
    return uri;
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    return RouteInformation(location: configuration.path);
  }
}

class _RouterDelegate extends RouterDelegate<Uri>
    with PopNavigatorRouterDelegateMixin {
  final _RouterState routerState;
  final List<Page> Function(Uri state) pageBuilder;

  _RouterDelegate({required this.routerState, required this.pageBuilder});

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

    return Navigator(
      key: navigatorKey,
      pages: pages,
      initialRoute: 'main/home',
    );
  }
}
