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
            if (state.path.contains('main')) const MaterialPage(child: Main()),
            if (state.path.contains('setting'))
              const MaterialPage(child: SettingScreen())
          ];
          return pages;
        }),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main() : super(key: const Key('main'));

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
              if (state.path.contains('item'))
                const MaterialPage(child: ContentsDetailScreen()),
            ];
            return pages;
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _routerState.state.path.contains('home') ? 0 : 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'contents'),
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

class SettingScreen extends StatelessWidget {
  const SettingScreen() : super(key: const Key('setting'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: ListView(
        children: const [
          SizedBox(height: 20),
          ListTile(
            title: Text('Scaffold Name'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          ListTile(
            title: Text('Scaffold Mail Address'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => _routerState.change(Uri(path: 'main/settings')),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _routerState.add('item_1'),
          child: Container(
              padding: const EdgeInsets.all(30), child: Text(item3.title)),
        ),
      ),
    );
  }
}

class ContentsScreen extends StatelessWidget {
  const ContentsScreen() : super(key: const Key('contents_list'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: ListView(
        children: [
          ...contentsList.map(
            (item) => ListTile(
              title: Text(item.title),
              onTap: (() {
                final id = item.id;
                _routerState.add('item_$id');
              }),
            ),
          )
        ],
      ),
    );
  }
}

class ContentsDetailScreen extends StatelessWidget {
  const ContentsDetailScreen() : super(key: const Key('contents_detail'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        margin: const EdgeInsets.all(30),
        width: double.infinity,
        child: const Text('title'),
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

  void add(String value) {
    String path = '${_state.path}/$value';
    _state = Uri(path: path);
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
    Uri uri = Uri.parse(routeInformation.location!);
    if (uri.path.isEmpty || uri.path == '/') {
      uri = Uri(path: 'main/home');
    }
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
