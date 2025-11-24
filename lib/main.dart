import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

// Import screens
import 'screens/splash/splash_screen_1.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/parent/parent_home_screen.dart';
import 'screens/home/therapist/therapist_home_screen.dart';
import 'screens/home/admin/admin_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Note: You need to configure Firebase for each platform:
  // 1. Add google-services.json to android/app/
  // 2. Add GoogleService-Info.plist to ios/Runner/
  // 3. Run: flutterfire configure
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Firebase initialization failed - app will run with mock data
    // To enable Firebase, configure it using: flutterfire configure
    debugPrint('Firebase initialization error: $e');
    debugPrint('Running app without Firebase. Configure Firebase to enable authentication.');
  }

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // App-wide color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2),
          primary: const Color(0xFF4A90E2),
          secondary: const Color(0xFF6BA3E8),
        ),
      ),
      home: const SplashScreen1(),
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
