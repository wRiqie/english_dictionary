import 'package:english_dictionary/app/routes/app_routes.dart';
import 'package:english_dictionary/app/ui/screens/favorites_screen.dart';
import 'package:english_dictionary/app/ui/screens/history_screen.dart';
import 'package:english_dictionary/app/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/helpers/dialog_helper.dart';
import '../../core/helpers/session_helper.dart';
import '../../data/repositories/auth_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GlobalKey<NavigatorState> navigatorKey;

  final authRepository = GetIt.I<AuthRepository>();
  final sessionHelper = GetIt.I<SessionHelper>();

  var currentIndex = 1;

  List<String> routes = [
    AppRoutes.history,
    AppRoutes.home,
    AppRoutes.favorites
  ];

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('English Dictionary'),
        leading: Container(
          margin: const EdgeInsets.all(4),
          child: CircleAvatar(
            backgroundColor: colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.home || settings.name == '/') {
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
              settings: settings,
            );
          } else if (settings.name == AppRoutes.favorites) {
            return MaterialPageRoute(
              builder: (_) => const FavoritesScreen(),
              settings: settings,
            );
          } else if (settings.name == AppRoutes.history) {
            return MaterialPageRoute(
              builder: (_) => const HistoryScreen(),
              settings: settings,
            );
          }
          return null;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
            routes[currentIndex],
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void signOut() async {
    DialogHelper().showDecisionDialog(
      context,
      title: 'Encerrar sessão',
      content: 'Tem certeza que deseja encerrar sua sessão?',
      onConfirm: () async {
        _clearSession();
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.signin,
          );
        }
      },
    );
  }

  Future<void> _clearSession() async {
    await authRepository.signOut();
    await sessionHelper.signOut();
  }
}