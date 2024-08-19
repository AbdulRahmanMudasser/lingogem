import 'package:flutter/material.dart';
import 'package:lingogem/screens/home_screen.dart';
import 'package:lingogem/screens/prompt_screen.dart';

class ToggleScreens extends StatefulWidget {
  const ToggleScreens({super.key});

  @override
  State<ToggleScreens> createState() => _ToggleScreensState();
}

class _ToggleScreensState extends State<ToggleScreens> {
  bool _showHomeScreen = true;

  void _toggleScreen() {
    setState(() {
      _showHomeScreen = !_showHomeScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showHomeScreen) {
      return HomeScreen(showPromptScreen: _toggleScreen);
    } else {
      return PromptScreen(showHomeScreen: _toggleScreen);
    }
  }
}
