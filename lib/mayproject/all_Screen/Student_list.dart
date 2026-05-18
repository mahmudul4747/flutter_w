import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  List<Map<String, dynamic>> students = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
 List<Map<String, dynamic>> filteredStudents = [];

final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
   Future.delayed(Duration.zero, () async {
  await getStudents();
});
  }
  void searchStudent(String value) {

  setState(() {

    filteredStudents = students.where((student) {

      final name =
          student['name'].toString().toLowerCase();

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

    await http.post(url, body: {
      "id": id,
    });

    await getStudents();
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

          key: _formKey,

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              TextFormField(

                controller: nameController,

                decoration: const InputDecoration(

                  hintText: "Name",
                  border: OutlineInputBorder(),

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
                  border: OutlineInputBorder(),

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

              if (_formKey.currentState!.validate()) {

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
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Name",
            border: OutlineInputBorder(),
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
            border: OutlineInputBorder(),
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
          if (_formKey.currentState!.validate()) {

        await updateStudentAPI(student['id'].toString());
        nameController.clear();
        emailController.clear();
        departmentController.clear();
        semesterController.clear();
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

      floatingActionButton: FloatingActionButton(
        onPressed: showAddStudentDialog,
        backgroundColor: const Color.fromARGB(214, 240, 219, 37),
        child: const Icon(Icons.add),
      ),

      body: Container(
        color: const Color.fromARGB(214, 240, 219, 37),

        child: Column(

          children: [

            const SizedBox(height: 40),

            const Text(
              "Student List",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            

            const SizedBox(height: 20),

            Expanded(

              child: Container(

  decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(30),
    ),
  ),

  child: Column(

    children: [

      // SEARCH BAR
      Padding(

  padding: const EdgeInsets.all(15),

  child: Container(

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(25),

      boxShadow: [

        BoxShadow(

          color: const Color.fromARGB(214, 240, 219, 37),

          spreadRadius: 3,

          blurRadius: 10,

          offset: const Offset(0, 3),

        ),

      ],

    ),

    child: TextField(

      controller: searchController,

      onChanged: searchStudent,

      decoration: InputDecoration(

        hintText: "Search Student",

        prefixIcon: const Icon(Icons.search),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25),

          borderSide: BorderSide.none,

        ),

      ),

    ),

  ),

),
      // LIST
      Expanded(

        child: ListView.builder(

          itemCount: filteredStudents.length,

          itemBuilder: (context, index) {

            return ListTile(

              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(214, 240, 219, 37),
                child: Icon(Icons.person, color: Color.fromARGB(221, 252, 251, 251)),
              ),

              title: Text(
                filteredStudents[index]['name'] ?? "",style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
              ),),

              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "Email: ${filteredStudents[index]['email']}", style: const TextStyle(color: Colors.black87),
                  ),

                /*  Text(
                    "Dept: ${filteredStudents[index]['department']}",
                  ),

                  Text(
                    "Sem: ${filteredStudents[index]['semester']}",
                  ),*/

                ],
              ),

              trailing: PopupMenuButton(

                onSelected: (value) async {

                if (value == 'edit') {
                  showEditDialog(filteredStudents[index]);
                }

                  else if (value == 'delete') {

                    await deleteStudentAPI(
                      filteredStudents[index]['id'].toString(),
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

                          );

                        },

                      ),

                    ),

                  ],

                ),

              ),


            )
          ],
        ),
      ),
    );
  }
}