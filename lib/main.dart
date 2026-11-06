import 'package:assessment/login.dart';
import 'package:assessment/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:assessment/profile.dart';
import 'package:assessment/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:assessment/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Home'),
        '/account': (context) => const AuthGate(), 

        // unnecessary because of AuthGate
        // '/login': (context) => LoginScreen(title: 'Login'),
        // '/profile':(context) => ProfileScreen(title: 'Profile'),


        '/register': (context) =>  RegisterScreen(title: 'Register'),
        // '/settings': (context) => SettingsScreen(),
        // '/static_data': (context) => StaticDataScreen()
      },
    );
  }
}
