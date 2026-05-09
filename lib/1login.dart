import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 

Future<void> login() async {
  var response = await http.post(
    Uri.parse('http://10.0.2.2/php/login.php'),
    body: {
      'email': emailController.text,
      'password': passwordController.text,
    },
  );

  var data = response.body;

  print(data);

  if (data.contains("success")) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Success")),
    );
    emailController.clear();
    passwordController.clear();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Failed")),
    );
    emailController.clear();
    passwordController.clear();
  }
}
@override
void dispose() {
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/emulatr.jpg'),fit: BoxFit.cover
        )
      ),child: Scaffold(
        backgroundColor: Colors.transparent,
      body:Stack(
        children:[ Container(
          padding: EdgeInsets.only(top: 150,left: 100,right: 20),
          child: Text("Welcome to \n   My New ", 
          style: TextStyle( fontSize: 40, 
          fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 20, 2, 2) ),),
          
        ),
         Container(
          padding: EdgeInsets.only(top: 250,left: 90,right: 20),
          child: Text("Enovation ", 
          style: TextStyle( fontSize: 60, 
          fontStyle:FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 48, 17, 224) ),),
          
        ),
        Container(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5,
        left: 30,right: 30),
           child:Column(
            children: [
            TextField(
              controller: emailController,
              decoration:InputDecoration(
                hintText: "Email / Phone",
                fillColor:Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              )
            ),
              SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:InputDecoration(
                hintText: "Password",
                fillColor:Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              )
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed:(){
               if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all fields")),
    );
  } else {
    login();
  } }, child: Text("Login",style: TextStyle(fontSize:25),
            ),style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 252, 171, 78),
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              )
            ),
              ),
              SizedBox(height: 20,),
              
           Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding:EdgeInsetsGeometry.only(top: 20,left: 0,right: 30) ),
              TextButton(onPressed:(){}, child: Text("Sign Up",
              style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 246, 247, 248)),)),
            
            TextButton(onPressed:(){}, child: Text("Forgot Password?",style: TextStyle(fontSize: 15,)))
            ],

           )
            
           ],
           ),
           ),

        ],
      ),
      
      
      )
    );
  }
}