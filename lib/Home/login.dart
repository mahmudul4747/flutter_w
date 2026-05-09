import 'package:flutter/material.dart';
import 'package:flutter_w/controller/login.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {    return Scaffold(
      body: Column(
        children: [
          TextField(controller: email),
          TextField(controller: pass),
          ElevatedButton(
            onPressed: () {
              auth.login(email.text, pass.text);
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
