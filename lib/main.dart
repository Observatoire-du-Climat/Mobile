import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:mobile/app_theme.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/repositories/measure_repository.dart';
import 'package:mobile/repositories/user_repository.dart';
import 'package:mobile/utils/secure_storage.dart';
import 'package:mobile/ui/pages/details/measure_details_page.dart';
import 'package:mobile/ui/pages/history_page.dart';
import 'package:mobile/ui/pages/home_page.dart';
import 'package:mobile/ui/pages/login_page.dart';
import 'package:mobile/ui/pages/measure_page.dart';
import 'package:mobile/ui/pages/measures/bird_migration_page.dart';
import 'package:mobile/ui/pages/measures/eggs_laying_page.dart';
import 'package:mobile/ui/pages/measures/snow_height_page.dart';
import 'package:mobile/ui/pages/measures/temperature_page.dart';
import 'package:mobile/ui/pages/profile_page.dart';
import 'package:mobile/ui/pages/profile_update_page.dart';
import 'package:mobile/ui/pages/register_page.dart';
import 'package:mobile/web_providers/measure_provider.dart';
import 'package:mobile/web_providers/user_provider.dart';

//Background notifications handler, can't be in a class, must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

/// Initializes the dependencies and start the application.
Future<void> main() async {

  //.env file initialization
  await dotenv.load(fileName: '.env');

  //SecureStorage initialization
  final storage = SecureStorage();

  //Provider and repository initialization
  final userProvider = UserProvider(storage, http.Client());
  final userRepository = UserRepository(userProvider);
  final measureProvider = MeasureProvider(storage, http.Client());
  final measureRepository = MeasureRepository(measureProvider);

  //Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  //to not rotate the phone
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(provisional: true, sound: true);
  //Subscribe to topic to get the notifications
  await messaging.subscribeToTopic("all-users");

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  runApp(MyApp(userRepository: userRepository, measureRepository: measureRepository,));
}

/// Root widget of the application.
///
/// Provides the BLoC, theme and navigation routes.
class MyApp extends StatelessWidget {

  final UserRepository userRepository;
  final MeasureRepository measureRepository;

  const MyApp({
    super.key,
    required this.userRepository,
    required this.measureRepository
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UserBloc(userRepository),
          ),
          BlocProvider(
            create: (_) => MeasureBloc(measureRepository),
          )
        ],
        child: MaterialApp(
          title: 'Observatoire Citoyen du Climat',
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
            '/home' : (context) => const HomePage(),
            '/measure-details' : (context) => const MeasureDetailsPage(),
            '/profile-update' : (context) => const ProfileUpdatePage()
          },
          home: HomePage(),
        )
      );
  }
}