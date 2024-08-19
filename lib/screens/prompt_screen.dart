import 'package:flutter/material.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key, required this.showHomeScreen});

  final VoidCallback showHomeScreen;

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Prompt Screen"),
      ),
    );
  }
}
