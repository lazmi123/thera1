import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import screens
import 'screens/splash/splash_screen_1.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/parent/parent_home_screen.dart';
import 'screens/home/therapist/therapist_home_screen.dart';
import 'screens/home/admin/admin_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // REQUIRED FOR TESTING

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thera1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SplashScreen1(), // MUST BE CONST IF POSSIBLE
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/parent-home': (context) => const ParentHomeScreen(),
        '/therapist-home': (context) => const TherapistHomeScreen(),
        '/admin-home': (context) => const AdminHomeScreen(),
      },
    );
  }
}
