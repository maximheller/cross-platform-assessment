import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  LoginScreenTab createState() => LoginScreenTab();
}

class LoginScreenTab extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('some login form')
          ],
        ),
      )
    );
  }
}
