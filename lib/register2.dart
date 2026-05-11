import 'package:flutter/material.dart';
import 'package:flutter_w/2login.dart';
import 'package:http/http.dart' as http;

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
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
        body: Container(
          child: Form(
            key: _formKey,
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                        backgroundColor: Colors.white,
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
                
                  

                 

                 )
              ],
            )),


        ),),
    );
  }
}