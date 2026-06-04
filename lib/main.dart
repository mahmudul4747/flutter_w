
import 'package:flutter/material.dart';


// Pages
import 'package:flutter_w/1login.dart';
import 'package:flutter_w/2login.dart';
import 'package:flutter_w/3rdlogin.dart';
import 'package:flutter_w/3rdreg.dart';
import 'package:flutter_w/Age_Calculator/core/theme/theme_provider.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/provider/age_provider.dart';
import 'package:flutter_w/Age_Calculator/mainc.dart';
import 'package:flutter_w/Home/login.dart';
import 'package:flutter_w/age.dart';
import 'package:flutter_w/mayproject/all_Screen/Student_list.dart';
import 'package:flutter_w/mayproject/mainp.dart';
import 'package:flutter_w/register..dart';

import 'package:flutter_w/register2.dart';
import 'package:flutter_w/Home/home2.dart';

// Controller
import 'package:flutter_w/controller/notification.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',

      // First Screen
      home: MyApp1(),

     
    );
  }
}