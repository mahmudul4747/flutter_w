import 'package:flutter/material.dart';
import 'package:flutter_w/Home/home_screen.dart';
import 'package:flutter_w/controller/login.dart';
import 'package:flutter_w/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyApp extends StatelessWidget {
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        home: auth.user.value == null
            ? LoginPage()
           // : HomePage(),
            : HomePage(),
      );
    });
  }
}
