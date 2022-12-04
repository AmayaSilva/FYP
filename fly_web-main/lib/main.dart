import 'package:flutter/material.dart';
import 'package:fly_web/pages/login.dart';
import 'package:fly_web/pages/medical_consultancy.dart';
import 'package:fly_web/pages/mental_health.dart';
import 'package:fly_web/pages/registered_pilots.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Navigation',
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        MentalHealthPage.routeName: (context) => const MentalHealthPage(),
        RegisteredPilotsPage.routeName: (context) =>
            const RegisteredPilotsPage(),
        MedicalConsultancyPage.routeName: (context) =>
            const MedicalConsultancyPage(),
      },
      theme: ThemeData(
        primaryColor: const Color(0XFF212D4F),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF212D4F),
          secondary: const Color(0XFF21517C),
        ),
      ),
    );
  }
}
