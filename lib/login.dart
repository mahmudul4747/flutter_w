import 'package:flutter/material.dart';
import 'package:flutter_w/Homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  const Text("Login..",
        style:TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87, 
        )
        ),
        backgroundColor: const Color.fromARGB(255, 89, 231, 7),
         centerTitle: true,
        elevation: 4,
        ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child:SingleChildScrollView(
              child:Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                SizedBox(height:  40,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email...",

                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",

                  ),
                ),SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("forget password..?",
                    style: TextStyle(
                        fontSize: 20,
                    color: Colors.black87),
                  ),            
                ),SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                       builder: (context) => const Home(),
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
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Already have an account..?",style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87
                    ),)
                  ],

                )
                ],
            )),)
      )

      ),
    );
    
    
  }

 
}
