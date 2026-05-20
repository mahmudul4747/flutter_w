import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_w/mayproject/all_Screen/stu_data.dart';
import 'package:http/http.dart' as http;



class StudentList extends StatefulWidget {
    final Function toggleTheme;
    
  const StudentList({super.key, required this.toggleTheme});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  List<Map<String, dynamic>> students = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
 
  final _addFormKey = GlobalKey<FormState>();
final _editFormKey = GlobalKey<FormState>();

  
 

List<Map<String, dynamic>> filteredStudents = [];

final TextEditingController searchController = TextEditingController();
  @override
void initState() {
  super.initState();
  filteredStudents = [];
  Future.delayed(Duration.zero, () async {
    await getStudents();
  });
}
  void searchStudent(String value) {

  setState(() {

    filteredStudents = students.where((student) {

      final name = (student['name'] ?? '').toString().toLowerCase();

      return name.contains(value.toLowerCase());

    }).toList();

  });

}


  // GET 
  
  Future<void> getStudents() async {

  try {

    var url = Uri.parse("http://10.0.2.2/php/stu_read.php");

    var response = await http.get(url);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);


      setState(() {

        students = List<Map<String, dynamic>>.from(data);


        filteredStudents = students;

      });

    }

  } catch (e) {

    print("Error: $e");

  }

}
  //  ADD 
  Future<void> addStudentAPI() async {

    var url = Uri.parse("http://10.0.2.2/php/stu_create.php");

    await http.post(url, body: {

      "name": nameController.text,
      "email": emailController.text,
      "department": departmentController.text,
      "semester": semesterController.text,

    });

    await getStudents();
  }

  // DELETE 
  Future<void> deleteStudentAPI(String id) async {
  var url = Uri.parse("http://10.0.2.2/php/stu_delete.php");

  var response = await http.post(url, body: {
    "id": id,
  });

  print("DELETE RESPONSE: ${response.body}");

  await getStudents();

  // 🔥 reset search too
  searchController.clear();
}
  // Update
  Future<void> updateStudentAPI(String id) async {
print("ID: $id");
print(nameController.text);
  var url = Uri.parse(
    "http://10.0.2.2/php/stu_update.php",
  );

  await http.post(url, body: {

    "id": id,
    "name": nameController.text,
    "email": emailController.text,
    "department": departmentController.text,
    "semester": semesterController.text,

  });
  
  await getStudents();

  setState(() {});

}
  // ADD DIALOG
  // ADD DIALOG
void showAddStudentDialog() {

  showDialog(
    context: context,
    builder: (context) {

      return AlertDialog(

        title: const Text("Add Student"),

        content: Form(

          key: _addFormKey,

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              TextFormField(

                controller: nameController,

                decoration: const InputDecoration(

                  hintText: "Name",
                  

                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {

                    return "Please Enter Name";

                  }

                  return null;

                },

              ),

              const SizedBox(height: 10),

              TextFormField(

                controller: emailController,

                decoration: const InputDecoration(

                  hintText: "Email",
                  

                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {

                    return "Please Enter Email";

                  }

                  if (!value.contains("@")) {

                    return "Enter Valid Email";

                  }

                  return null;

                },

              ),

            ],

          ),

        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: () async {

              if (_addFormKey.currentState!.validate()) {

                await addStudentAPI();

                nameController.clear();
                emailController.clear();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(

                  const SnackBar(

                    content: Text("Student Added Successfully"),

                  ),

                );

              }

            },

            child: const Text("Add"),

          ),

        ],

      );

    },

  );

}
  // EDIT DIALOG
  void showEditDialog(Map<String, dynamic> student) {

    nameController.text = student['name'] ?? "";
    emailController.text = student['email'] ?? "";
   

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
  title: const Text("Edit Student"),
  content: Form(
    key: _editFormKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Name",
            
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Name";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: "Email",
           
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Email";
            }
            if (!value.contains("@")) {
              return "Enter Valid Email";
            }
            return null;
          },
        ),
      ],
    ),
  ),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Cancel"),
    ),

    ElevatedButton(
      onPressed: () async {
          if (_editFormKey.currentState!.validate()) {

        await updateStudentAPI(student['id'].toString());
        nameController.clear();
        emailController.clear();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Student Updated Successfully"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all fields"),
          ),
        );
      }
      },
      child: const Text("Update"),
    ),
  ],

);

      },
    );
  }

  //  UI 
  @override
Widget build(BuildContext context) {
  return Scaffold(

   floatingActionButton: Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,

    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF6C63FF),
        Color(0xFF8E7CFF),
        Color(0xFF2D1B69),
      ],
    ),

    boxShadow: [
      BoxShadow(
        color: const Color(0xFF6C63FF).withOpacity(0.5),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ],
  ),

  child: FloatingActionButton(
    onPressed: showAddStudentDialog,

    backgroundColor: Colors.transparent,
    elevation: 0,

    child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
  ),
),  


    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(246, 29, 60, 194),
            Color(0xFF8E7CFF),
            Color(0xFF2D1B68),
          ],
        ),
      ),

      child: Column(
        children: [

          const SizedBox(height: 50),

          // TITLE
          Text(
            "Student List",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Poppins",
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
              ),

              child: Column(
                children: [

                  // ================= SEARCH BAR (GLASS STYLE) =================
                  Padding(
                    padding: const EdgeInsets.all(15),

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),

                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.9),
                            const Color.fromARGB(255, 81, 132, 190).withOpacity(0.5),
                            Colors.white.withOpacity(0.9),

                          ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 135, 160, 226),
                              
                            blurRadius: 6,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: TextField(
                        controller: searchController,
                        onChanged: searchStudent,

                        decoration: InputDecoration(
                          hintText: "Search Student...",

                          prefixIcon: const Icon(Icons.search),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),

                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),

                  // ================= LIST =================
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredStudents.length,

                      itemBuilder: (context, index) {

                        final student = filteredStudents[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade100,
                                ],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 170, 167, 167),
                                  blurRadius: 8,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),

                              leading: Hero(
                                tag: student['id'],
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFF6C63FF),
                                  child: Text(
                                    student['name'][0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              title: Text(
                                student['name'] ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              subtitle: Text(
                                student['email'] ?? "",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              trailing: PopupMenuButton(
                                onSelected: (value) async {
                                  if (value == 'edit') {
                                    showEditDialog(student);
                                  } else if (value == 'delete') {
                                    await deleteStudentAPI(
                                      student['id'].toString(),
                                    );
                                  }
                                },

                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text("Edit"),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentDetailsPage(
                                      student: student,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  }
