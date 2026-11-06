import 'package:assessment/auth/auth_service.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.title});

  final String title;

  @override
  ProfileScreenTab createState() => ProfileScreenTab();
}

class ProfileScreenTab extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Welcome, ${user?.email ?? 'User'}'),
            
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await AuthService.instance.signOut();
              },
              child: const Text('Logout'),
            ),

          ],
        ),
      )
    );
  }
}
