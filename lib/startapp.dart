import 'package:flutter/material.dart';
import 'package:flutter_w/login.dart';
import 'package:flutter_w/register..dart';
class Start1 extends StatelessWidget {
  const Start1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "✨✨ Welcome To My Smart App 🌟🌟",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 81, 117),
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.blueAccent,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),

                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute<void>(
                       builder: (context) => const LoginPage(),
                       ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 89, 231, 7),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                       builder: (context) => const RegisterPage(),
                       ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 241, 161, 41),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // 🌈 Footer Text
                  Text(
                    "Stay Positive 🌞 Keep Growing 💪",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
