import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_w/mayproject/all_Screen/Student_list.dart';


class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
   final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async{
    var response = await http.post(Uri.parse('http://10.0.2.2/php/login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });

    var data = response.body;

    print(data);

    if (data.contains("success")) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Login Success")),
  );

 Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const StudentList(),
  ),
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
        image: DecorationImage(image: AssetImage("assets/emu2.jpg"),fit: BoxFit.cover)
),
child: Scaffold(
  backgroundColor: Colors.transparent,
  body: Stack(
    children: [
      Container(
        padding: EdgeInsets.only(top: 120, right: 20, left: 50),
        child: Text("We are \nHiring",style: TextStyle(fontSize: 65,color: Colors.white,fontWeight: FontWeight.bold ),),
      ),
      
      SizedBox(height: 20,),
      Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.54, right: 20, left: 50),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email / Phone",
                fillColor: const Color.fromARGB(255, 217, 237, 243),
                filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
              )
            ),
          ),
        SizedBox(height: 20,),
         TextField(
          controller: passwordController,
           obscureText: true,
           decoration: InputDecoration(
            hintText: "Password",
            fillColor: const Color.fromARGB(255, 217, 237, 243),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            )
          ),
          
        ),
       SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
         if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all fields")),
    );
  } else {
    login();
  }
        }, child: Text("Login",style: TextStyle(color: const Color.fromARGB(255, 5, 3, 3),fontWeight: FontWeight.bold,fontSize: 30),),style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 33, 235, 208),
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ) 
        ),),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){}, child: Text("Sign Up",style: TextStyle(color: const Color.fromARGB(255, 5, 3, 3),fontWeight: FontWeight.bold,fontSize: 20),)),
             SizedBox(width: 20,),
             
            TextButton(onPressed: (){}, child: Text("Forgot Password?",style: TextStyle(color:Color.fromARGB(255, 11, 46, 248),fontWeight: FontWeight.bold,fontSize: 20),))
          ],
        )

          ]
        ),
      )
    ]
  ),
),
    );
        
  }
}