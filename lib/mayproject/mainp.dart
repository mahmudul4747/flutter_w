import 'package:flutter/material.dart';
import 'package:flutter_w/2login.dart';

class Project2 extends StatelessWidget {
  const Project2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: Login2(),
      

    );
  }
}