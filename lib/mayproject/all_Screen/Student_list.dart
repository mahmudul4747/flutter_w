import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  List<Map<String, String>> students = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Add Student Function
  void addStudent(){
    if(nameController.text.isNotEmpty
    && emailController.text.isNotEmpty
    && departmentController.text.isNotEmpty
    && semesterController.text.isNotEmpty
    ){
      setState(() {
        students.add({
          'name': nameController.text,
          'email': emailController.text,
          'department': departmentController.text,
          'semester': semesterController.text,
        });
      });
      // Clear Fields
      nameController.clear();
      emailController.clear();
      departmentController.clear();
      semesterController.clear();
      Navigator.pop(context);
    }
  } 
   // Dialog Box
  void showAddStudentDialog(){

    showDialog(
      context: context,
      builder: (context){

        return AlertDialog(

          title: const Text("Add Student"),

          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter student name",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter student email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: departmentController,
                  decoration: const InputDecoration(
                    hintText: "Enter student department",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: semesterController,
                  decoration: const InputDecoration(
                    hintText: "Enter student semester",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          

          actions: [

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: addStudent,
              child: const Text("Add"),
            ),

          ],
        );

      },
    );

  }
  void deleteStudent(int index){

  setState(() {

    students.removeAt(index);

  });

}
void editStudent(int index){

  nameController.text = students[index]['name']!;
  emailController.text = students[index]['email']!;
  departmentController.text = students[index]['department']!;
  semesterController.text = students[index]['semester']!;

  showDialog(

    context: context,

    builder: (context){

      return AlertDialog(

        title: const Text("Update Student"),

        content: SingleChildScrollView(

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: departmentController,
                decoration: const InputDecoration(
                  labelText: "Department",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: semesterController,
                decoration: const InputDecoration(
                  labelText: "Semester",
                ),
              ),

            ],

          ),

        ),

        actions: [

          TextButton(

            onPressed: (){
              Navigator.pop(context);
            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: (){

              setState(() {

                students[index] = {

                  'name': nameController.text,
                  'email': emailController.text,
                  'department': departmentController.text,
                  'semester': semesterController.text,

                };

              });

              Navigator.pop(context);

            },

            child: const Text("Update"),

          ),

        ],

      );

    },

  );

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   floatingActionButton: FloatingActionButton(
        onPressed: showAddStudentDialog,
        child: const Icon(Icons.add),
      ),

      
      body: Container(
        color: const Color.fromARGB(255, 245, 221, 8),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 221, 8),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Center(
                child: Text(
                  "Student List",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView.builder(

                  itemCount: students.length,

                  itemBuilder: (context,index){

                    return ListTile(
                    

                      leading: CircleAvatar(

                            radius: 30,

                            backgroundImage: AssetImage(
                              "assets/plant15.png",
                            ),

                          ),

                      title: Text(
                        students[index]['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Email: ${students[index]['email']}"),

                            Text("Department: ${students[index]['department']}"),

                            Text("Semester: ${students[index]['semester']}"),

                          ],
                        ),trailing: PopupMenuButton(

                          onSelected: (value){

                            if(value == 'edit'){

                              editStudent(index);

                            }

                            else if(value == 'delete'){

                              deleteStudent(index);

                            }

                          },

                          itemBuilder: (context) => [

                            const PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),

                            const PopupMenuItem(
                              value: 'delete',
                              child: Text("Delete"),
                            ),

                          ],

                        ), 

                    );

                
                  
                  }
                ),
              )
            

            ),
            
          ],

        ),
      ),
    
    );
  }
}