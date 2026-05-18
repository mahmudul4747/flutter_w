import 'package:flutter/material.dart';
import 'package:flutter_w/mayproject/all_Screen/Student_list.dart';

class Project2 extends StatefulWidget {
  const Project2({super.key});

  @override
  State<Project2> createState() => _Project2State();
}

class _Project2State extends State<Project2> {

  bool isDark = false;

  void toggleTheme() {

    setState(() {

      isDark = !isDark;

    });

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode:
          isDark ? ThemeMode.dark : ThemeMode.light,

      home: StudentList(
        toggleTheme: toggleTheme,
      ),

    );

  }
}