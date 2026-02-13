import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ added

import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/setup_profile.dart';
import 'screens/counseling_onbording.dart';
import 'screens/counseling_phase1.dart';
import 'screens/counseling_phase2.dart';
import 'screens/counseling_phase3.dart';
import 'screens/counseling_phase4.dart';
import 'screens/profile.dart';
import 'screens/notification.dart';
import 'screens/streams.dart';
import 'screens/colleges.dart';
import 'screens/courses.dart';
import 'screens/splash_screen.dart';
import 'screens/aichat_screen.dart';
import 'screens/scholarship.dart';
import 'screens/exams.dart';
import 'screens/internship.dart';
import 'screens/science.dart';
import 'screens/commerce.dart';
import 'screens/arts.dart';
import 'screens/course_detail.dart';
import 'screens/signup.dart';



// ✅ edited here (async + initialize firebase)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CalSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),

      // ✅ KEEP THIS
      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const Onboarding(),
        '/login': (context) => const Login(),
        '/setup_profile': (context) => const SetupProfile(),
        '/home': (context) => const Home(),
        '/counseling_onboarding': (context) => const CounselingOnboarding(),
        '/counseling_phase1': (context) => const CounselingPhase1(),
        '/counseling_phase2': (context) => const CounselingPhase2(),
        '/counseling_phase3': (context) => const CounselingPhase3(),
        '/counseling_phase4': (context) => const CounselingPhase4(),
        '/profile': (context) => const Profile(),
        '/notification': (context) => const NotificationScreen(),
        '/streams': (context) => const Streams(),
        '/collages': (context) => const Colleges(),
        '/courses': (context) => const Courses(),
        '/aichat_screen': (context) => const AichatScreen(),
        '/scholarship': (context) => const Scholarship(),
        '/exams': (context) => const Exams(),
        '/internship': (context) => const Internship(),
        '/science': (context) => const Science(),
        '/commerce': (context) => const Commerce(),
        '/arts': (context) => const Arts(),
        '/signup': (context) => const Signup(),

      },
    );
  }
}

