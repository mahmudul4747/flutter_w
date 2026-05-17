import 'package:flutter/material.dart';

class StuData extends StatelessWidget {
  const StuData({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        
          
        body: Center(
          child:  Text(
            "Student Data",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}