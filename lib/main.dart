import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:flutter_w/1login.dart';
import 'package:flutter_w/2login.dart';
import 'package:flutter_w/3rdlogin.dart';
import 'package:flutter_w/3rdreg.dart';
import 'package:flutter_w/Home/login.dart';
import 'package:flutter_w/mayproject/mainp.dart';
import 'package:flutter_w/register..dart';

import 'package:flutter_w/register2.dart';
import 'package:flutter_w/Home/home2.dart';

// Controller
import 'package:flutter_w/controller/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialize
  try {
    await Firebase.initializeApp();
    debugPrint("Firebase Initialized");
  } catch (e) {
    debugPrint("Firebase Error: $e");
  }

  // Notification Initialize
  try {
    await initNotification();
    debugPrint("Notification Initialized");
  } catch (e) {
    debugPrint("Notification Error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',

      // First Screen
      home: Project2(),

     
    );
  }
}