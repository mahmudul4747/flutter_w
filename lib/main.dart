import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_w/1login.dart';
import 'package:flutter_w/2login.dart';
import 'package:flutter_w/3rdlogin.dart';
import 'package:flutter_w/controller/notification.dart';
import 'package:flutter_w/register..dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase Error: $e");
  }

  try {
    await initNotification();
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
      home: RegisterPage(),
    );
  }
}
