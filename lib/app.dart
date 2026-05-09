import 'package:flutter/material.dart';

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: const Center(child: Text("Hello World")),
      ),
    );
  }
}
