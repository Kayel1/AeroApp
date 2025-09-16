import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/controls/controls_page.dart';
import 'features/intro/intro_page.dart';
import 'theme/app_theme.dart';
import 'features/auth/login_page.dart';
import 'features/growth/growth_log_page.dart';
import 'providers/auth_providers.dart';
import 'services/auth_service.dart';

class AeroApp extends ConsumerStatefulWidget {
  const AeroApp({super.key});

  @override
  ConsumerState<AeroApp> createState() => _AeroAppState();
}

class _AeroAppState extends ConsumerState<AeroApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final light = AppTheme.light();
    final dark = AppTheme.dark();

    final pages = <Widget>[
      const DashboardPage(),
      const ControlsPage(),
    ];

    return MaterialApp(
      title: 'Aero Control',
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(onLoggedIn: () => Navigator.of(context).pushReplacementNamed('/intro')),
        '/intro': (context) => IntroPage(onGetStarted: () => Navigator.of(context).pushReplacementNamed('/main')),
        '/main': (context) => MainShell(
              pages: pages,
              onIndexChanged: (i) => setState(() => _currentIndex = i),
              currentIndex: _currentIndex,
            ),
      },
    );
  }
}

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.pages, required this.onIndexChanged, required this.currentIndex});
  final List<Widget> pages;
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authServiceProvider).currentUser;
    final isAdmin = user?.role == UserRole.admin;
    final visiblePages = <(IconData, String, Widget)>[
      (Icons.dashboard_outlined, 'Dashboard', pages[0]),
      if (isAdmin) (Icons.tune_outlined, 'Controls', pages[1]),
      if (isAdmin) (Icons.book_outlined, 'Growth', const GrowthLogPage()),
    ];
    final safeIndex = currentIndex.clamp(0, visiblePages.length - 1);
    // If only one page (non-admin), hide bottom nav but keep drawer for logout
    if (visiblePages.length < 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text(visiblePages.first.$2),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'logout') {
                  await ref.read(authServiceProvider).signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'logout', child: Text('Logout')),
              ],
            ),
          ],
        ),
        body: SafeArea(child: visiblePages.first.$3),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(visiblePages[safeIndex].$2),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                await ref.read(authServiceProvider).signOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: SafeArea(child: visiblePages[safeIndex].$3),
      bottomNavigationBar: NavigationBar(
        selectedIndex: safeIndex,
        destinations: [
          for (final item in visiblePages)
            NavigationDestination(icon: Icon(item.$1), selectedIcon: Icon(item.$1), label: item.$2),
        ],
        onDestinationSelected: onIndexChanged,
      ),
    );
  }
}


