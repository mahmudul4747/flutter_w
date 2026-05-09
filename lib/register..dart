import 'package:flutter/material.dart';
import 'package:flutter_w/1login.dart';
import 'package:flutter_w/Colors.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  Future <void> register()async {
     var response = await http.post(Uri.parse('http://10.0.2.2/php/register.php'), body: {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'country': countryController.text,
      'phone': phoneController.text,
    });
    var data = response.body;
      
      print(data);

      if (data.contains("success")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Success")),
      );
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      countryController.clear();
      phoneController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed")),
      );
      usernameController.clear();
      emailController.clear();  
      passwordController.clear();
      countryController.clear();
      phoneController.clear();
    }
  }

   @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    phoneController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 60,
        title: const Text(
          "Register",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: MainColor,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
              
                  // Username field
                   TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username...",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a username";
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(height: 40),
              
                  // Email
                   TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email...",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      if(!value.contains('@') || !value.contains('.')) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(height: 40),
              
                  // Password
                   TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password...",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(height: 40),
              
                  // Country
                   TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: "Country...",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a country";
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(height: 40),
              
                  // Phone
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Mobile/Phone...",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a phone number";
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(height: 24),
              
                  // Submit Button
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        if 
                        (_fromKey.currentState!.validate()) {
                         Future <void> register() async{
                          var response = http.post(Uri.parse('http://10.0.2.2/php/register.php'), body: {
                            'username': usernameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'country': countryController.text,
                            'phone': phoneController.text,
                          });
                          response.then((res) {
                            var data = res.body;
                            print(data);
              
                            if (data.contains("success")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Registration Success")),
                              );
                              usernameController.clear();
                              emailController.clear();
                              passwordController.clear();
                              countryController.clear();
                              phoneController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Registration Failed")),
                              );
                              usernameController.clear();
                              emailController.clear();  
                              passwordController.clear();
                              countryController.clear();
                              phoneController.clear();
                            }
                          });
                         }
                        
                        Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      });
                        }
                   },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
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
