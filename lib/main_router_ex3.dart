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
      //
      routeInformationParser: const _RouteInformationParser(),
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            if (state.path.contains('main')) const MaterialPage(child: RMain()),
            if (state.path.contains('settings')) const MaterialPage(fullscreenDialog: true, child: SSettings()),
          ];
          return pages;
        },
      ),
    );
  }
}

class RMain extends StatelessWidget {
  const RMain() : super(key: const Key('r_main'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: _RouterDelegate(
          routerState: _routerState,
          pageBuilder: (state) {
            final pages = [
              if (state.path.contains('home')) const MaterialPage(child: RHome()),
              if (state.path.contains('contents')) const MaterialPage(child: RContents()),
            ];

            return pages;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'contents'),
        ],
        currentIndex: _routerState.state.path.contains('home') ? 0 : 1,
        onTap: ((value) {
          if (value == 0) {
            _routerState.change(Uri(path: '/main/home'));
          } else if (value == 1) {
            _routerState.change(Uri(path: '/main/contents'));
          }
        }),
      ),
    );
  }
}

class RHome extends StatelessWidget {
  const RHome() : super(key: const Key('r_home'));
  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            const MaterialPage(child: SHome()),
            if (state.path.contains('content_detail')) const MaterialPage(child: SContentDetail())
          ];
          return pages;
        },
      ),
    );
  }
}

class RContents extends StatelessWidget {
  const RContents() : super(key: const Key('r_contents'));
  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _RouterDelegate(
        routerState: _routerState,
        pageBuilder: (state) {
          final pages = [
            const MaterialPage(child: SContents()),
            if (state.path.contains('content_detail')) const MaterialPage(child: SContentDetail())
          ];
          return pages;
        },
      ),
    );
  }
}

class SHome extends StatelessWidget {
  const SHome() : super(key: const Key('s_home'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            splashRadius: 1,
            onPressed: () {
              _routerState.change(Uri(path: '/main/home/settings'));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(50),
        children: [
          const Text('Recommend Content'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _routerState.change(Uri(path: '/main/home/content_detail'));
            },
            child: const Text('content 1'),
          )
        ],
      ),
    );
  }
}

class SContents extends StatelessWidget {
  const SContents() : super(key: const Key('s_contents'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contents Page')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Content 1'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _routerState.change(Uri(path: '/main/contents/content_detail'));
            },
          ),
        ],
      ),
    );
  }
}

class SContentDetail extends StatelessWidget {
  const SContentDetail() : super(key: const Key('s_content_detail'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content Detail')),
      body: const Center(child: Text('content detail page')),
    );
  }
}

class SSettings extends StatelessWidget {
  const SSettings() : super(key: const Key('s_settings'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
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
        ));
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
    if (uri.path.isEmpty || uri.path == '/') {
      uri = Uri(path: '/main/home');
    }
    return uri;
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    print(configuration);
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