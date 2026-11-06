import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assessment/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  LoginScreenTab createState() => LoginScreenTab();
}

class LoginScreenTab extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    //! before the expression means NOT
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await AuthService.instance.signIn(
        //.trim() removes whitespaces in the beginning and end of the String
        _emailController.text.trim(),
        _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.code == 'too-many-requests'
            ? 'Too many attempts. Try again later.'
            : 'Unable to log in. Check your credentials.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),

                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: Text(_isLoading ? 'Logging in...' : 'Login'),
                ),

                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
