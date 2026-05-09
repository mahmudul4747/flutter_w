
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login3rd extends StatefulWidget {
  const Login3rd({super.key});

  @override
  State<Login3rd> createState() => _Login3rdState();
}

class _Login3rdState extends State<Login3rd> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
     var response = await http.post(Uri.parse('http://10.0.2.2/php/login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/img34.jpg'),fit:BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding:EdgeInsets.only(top: 150,left: 50,right: 20),
                child: Text('Welcome \n     my Application',style:TextStyle(fontSize: 60, fontStyle: FontStyle.italic,fontWeight: FontWeight.w900,color: const Color.fromARGB(221, 241, 240, 240)) ),

              ),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5, left: 30, right: 30)  ,
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText:'User Email',
                        fillColor: Colors.white70, 
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText:'Password',
                        fillColor: Colors.white70, 
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")),
                        );
                      } else {
                        login();
                      }
                    }, child: Text('login',style: TextStyle(fontSize:30,
                    fontWeight: FontWeight.bold,color: Colors.black87,

                    ),
                    ),style: ElevatedButton.styleFrom(
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
                          TextButton(onPressed: (){}, child: Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color.fromARGB(221, 50, 194, 230)),)),
                          SizedBox(width: 20,),
                          TextButton(onPressed: (){}, child: Text('Forgot Password?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color.fromARGB(221, 50, 194, 230)),)),
                        ],
                      ),
                  ],
                ),
                
              )
            ],
          ),
        ),

     
    );
  }
}