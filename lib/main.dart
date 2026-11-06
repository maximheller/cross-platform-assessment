import 'package:assessment/login.dart';
import 'package:assessment/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
        '/login': (context) => LoginScreen(title: 'Login'),
        // '/register': (context) =>  RegisterScreen(),
        // '/settings': (context) => SettingsScreen(),
        // '/static_data': (context) => StaticDataScreen()
        // TODO Profile
      },
    );
  }
}
