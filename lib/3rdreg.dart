import 'package:flutter/material.dart';
import 'package:flutter_w/3login.dart';
import 'package:http/http.dart' as http;

class Register3 extends StatefulWidget {
  const Register3({super.key});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();  
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> register() async {
    var response = await http.post(Uri.parse('http://10.0.2.2/php/register.php'), body: {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed")),
      );
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/emu2.jpg"),fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child:SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  children: [
                    Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: Icon(Icons.person),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        
                      ),
                    ),
                    validator:(value){
                      if(value == null || value.isEmpty){
                        return "Please enter a username";
                      }
                      return null;
                    },
                  ),
                   const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                     validator:(value){
                      if(value == null || value.isEmpty){
                        return "Please enter an email";
                      }
                      return null;
                    },
                  ),
                    const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40 ),
                      ),
                    ),
                     validator:(value){
                      if(value == null || value.isEmpty){
                        return "Please enter a password";
                      }
                      if(value.length < 6){
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                   const SizedBox(height: 20),
                   SizedBox(width: 200,
                  child:ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                       Future<void> register() async {
            try {
              var response = await http.post(
                Uri.parse('http://10.0.2.2/php/register.php'),
                body: {
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
                },
              );
          
              var data = response.body;
          
              print(data);
          
              if (data.contains("success")) {
                ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Success")),
                );
          
                usernameController.clear();
                emailController.clear();
                passwordController.clear();
                
          
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Failed")),
                );
              }
          
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: $e")),
              );
            }
          }
                          Future.delayed(Duration(seconds: 2), () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login2()
                          )
                          );
                          
                          }
                          );
                        // Process registration
                      }
                  
                      
                  
          
                    }, style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 160, 42, 207),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                  
                    
          
                   
          
                   )
                ],
              )),
          
          
          ),
          
        
        ),


          ]
      ),
    ),
    );


  }
}
