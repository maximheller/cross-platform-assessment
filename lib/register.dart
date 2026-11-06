import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assessment/auth/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  RegisterScreenTab createState() => RegisterScreenTab();
}

class RegisterScreenTab extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    if(_formKey.currentState!.validate()==false){
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;  
    });

    try {
      await AuthService.instance.register(
        _emailController.text.trim(),
        _passwordController.text,
      );

      //Registration successful
      if(!mounted) return;
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      //Registration failed
      //checks if state object is currently attached to the widget tree
      //in other words: mounted checks whether it is still valid to update the widget's state
      if (!mounted) return;

      setState(() {
        _errorMessage = e.code;
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
    _confirmPasswordController.dispose();
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

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if(value != _passwordController.text) {
                      return 'Passwords do not match';
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
                  onPressed: _isLoading ? null : _register,
                  child: Text(_isLoading ? 'Registering...' : 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
