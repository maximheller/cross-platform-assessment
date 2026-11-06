import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key, 
    required this.title, 
    required this.themeMode, 
    required this.onThemeChanged
    });

  final String title;

  final ThemeMode themeMode;
  //ValueChanged<ThemeMode> is a Flutter function type.
  //Allows to pass a function as a variable.
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  SettingsScreenTab createState() => SettingsScreenTab();
}

class SettingsScreenTab extends State<SettingsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: RadioGroup<ThemeMode>(
          groupValue: widget.themeMode,
          onChanged: (ThemeMode? value) {
            if(value!=null) {
              widget.onThemeChanged(value);
            }
          },
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('System'),
                value: ThemeMode.system,
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                value: ThemeMode.light,
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                value: ThemeMode.dark,
              ),
            ],
          ),
        )
      )
    );
  }
}