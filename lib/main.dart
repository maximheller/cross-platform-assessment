import 'package:assessment/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:assessment/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assessment/settings.dart';

import 'firebase_options.dart';

import 'package:assessment/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  ThemeMode _themeMode = ThemeMode.system;

  final _prefs = SharedPreferencesAsync();

  Future<void> _changeTheme(ThemeMode newTheme) async {
    setState(() {
      _themeMode = newTheme;
    });
    //.name converts the enum to a String
    await _prefs.setString('theme_mode', newTheme.name);
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _prefs.getString('theme_mode');
    //ThemeMode.values.any((mode) => mode.name == savedTheme ensures that the ThemeMode actually exists
    if(mounted && savedTheme!=null && ThemeMode.values.any((mode) => mode.name == savedTheme)) {
      setState(() {
          _themeMode = ThemeMode.values.byName(savedTheme);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Home'),
        '/account': (context) => const AuthGate(),
        '/register': (context) => RegisterScreen(title: 'Register'),
        '/settings': (context) => SettingsScreen(
          title: 'Settings',
          themeMode: _themeMode,
          onThemeChanged: _changeTheme,
          ),
        // unnecessary because of AuthGate
        // '/login': (context) => LoginScreen(title: 'Login'),
        // '/profile':(context) => ProfileScreen(title: 'Profile'),

        // '/static_data': (context) => StaticDataScreen()
      },
    );
  }
}
