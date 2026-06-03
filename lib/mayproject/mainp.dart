import 'package:flutter/material.dart';
import 'package:flutter_w/mayproject/all_Screen/Loginp.dart';
import 'package:flutter_w/mayproject/all_Screen/Registerp.dart';
import 'package:flutter_w/mayproject/all_Screen/Student_list.dart';

class Project2 extends StatelessWidget {
  const Project2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',

      routes: {
        '/login': (context) => const Loginp(),
        '/register': (context) => const Registerp(),
        '/list': (context) => const StudentList(),
      },
    );
  }
}