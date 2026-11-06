import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
            icon: Icon(Icons.account_circle_outlined),
            //tooltip showes "details" of what the button does when the user holds the button on mobile
            tooltip: 'Profile',
            ),
        ],

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Text'),
          ],
        ),
      ),
    );
  }
}
