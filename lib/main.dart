import 'package:flutter/material.dart';
import 'package:mobile/app_theme.dart';
import 'package:mobile/ui/pages/history_page.dart';
import 'package:mobile/ui/pages/home_page.dart';
import 'package:mobile/ui/pages/login_page.dart';
import 'package:mobile/ui/pages/measure_page.dart';
import 'package:mobile/ui/pages/measures/bird_migration_page.dart';
import 'package:mobile/ui/pages/measures/eggs_laying_page.dart';
import 'package:mobile/ui/pages/measures/snow_height_page.dart';
import 'package:mobile/ui/pages/measures/temperature_page.dart';
import 'package:mobile/ui/pages/profile_page.dart';
import 'package:mobile/ui/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      routes: {
        '/measure' : (context) => const MeasurePage(),
        '/temperature' : (context) => const TemperaturePage(),
        '/snow_height' : (context) => const SnowHeightPage(),
        '/bird_migration' : (context) => const BirdMigrationPage(),
        '/eggs_laying' : (context) => const EggsLayingPage(),
        '/history' : (context) => const HistoryPage(),
        '/profile' : (context) => const ProfilePage(),
        '/login' : (context) => const LoginPage(),
        '/register' : (context) => const RegisterPage(),
        '/home' : (context) => const HomePage()
      },
      home: Scaffold(
          body: TestPage()),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: Center(
        child: Text("Observatoire du Climat"),
      ),
    );
     */
    return HomePage();
  }
}