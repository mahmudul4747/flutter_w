import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_w/Homepage.dart';



class AuthTabPage extends StatelessWidget {
  const AuthTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // ২টা ট্যাব: Login & Register
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Portal',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 241, 155, 25),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login), text: "Login"),
              Tab(icon: Icon(Icons.app_registration), text: "Register"),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black54,
          ),
        ),
        body: 
        const TabBarView(
          children: [
            LoginTab(),
            RegisterTab(),
          ],
        ),
      ),
    );
  }
}

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> loginUser() async {
    var url = Uri.parse("http://10.0.2.2/php/login.php");

    var response = await http.post(url, body: {
      "email": email.text,
      "password": password.text,
    });

    if (response.statusCode == 200 && response.body.contains("success")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email or Password ❌'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: loginUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 241, 155, 25),
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterTab extends StatefulWidget {
  const RegisterTab({super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController phone = TextEditingController();

  Future<void> registerUser() async {
    var url = Uri.parse("http://10.0.2.2/php/register.php");

    var response = await http.post(url, body: {
      "username": username.text,
      "email": email.text,
      "password": password.text,
      "country": country.text,
      "phone": phone.text,
    });

    // ✅ Debug log — response দেখতে console এ প্রিন্ট হবে
    print("Response: ${response.body}");

    if (response.statusCode == 200 && response.body.contains("success")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Successful 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Failed ❌'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: country,
              decoration: const InputDecoration(labelText: "Country"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: registerUser, // ✅ এখানেই function কল হবে
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 241, 155, 25),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
