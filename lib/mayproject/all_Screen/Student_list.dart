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
print("data successfully fetched"); 
      final data = jsonDecode(response.body);

print("Imran: $data");
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
  void showAddStudentDialog() {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

  title: const Text("Add Student"),

  content: Column(

    mainAxisSize: MainAxisSize.min,

    children: [

      TextField(

        controller: nameController,

        decoration: const InputDecoration(
          hintText: "Name",
        ),

      ),

      const SizedBox(height: 10),

      TextField(

        controller: emailController,

        decoration: const InputDecoration(
          hintText: "Email",
        ),

      ),

    ],

  ),

  actions: [

    TextButton(

      onPressed: () => Navigator.pop(context),

      child: const Text("Cancel"),

    ),

    ElevatedButton(

      onPressed: () async {

        await addStudentAPI();

        nameController.clear();
        emailController.clear();

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text("Student Added Successfully"),

          ),

        );

      },

      child: const Text("Add"),

    ),

  ],

);
      },
    );
  }
  void showEditDialog(Map<String, dynamic> student) {

  nameController.text = student['name'];
  emailController.text = student['email'];
  departmentController.text = student['department'];
  semesterController.text = student['semester'];

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text("Update Student"),

        content: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            TextField(

              controller: nameController,

              decoration: const InputDecoration(
                hintText: "Name",
              ),

            ),

            const SizedBox(height: 10),

            TextField(

              controller: emailController,

              decoration: const InputDecoration(
                hintText: "Email",
              ),

            ),

            const SizedBox(height: 10),

            TextField(

              controller: departmentController,

              decoration: const InputDecoration(
                hintText: "Department",
              ),

            ),

            const SizedBox(height: 10),

            TextField(

              controller: semesterController,

              decoration: const InputDecoration(
                hintText: "Semester",
              ),

            ),

          ],

        ),

        actions: [

          TextButton(

            onPressed: (){
              Navigator.pop(context);
            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: () async {

              await updateStudentAPI(
                student['id'].toString(),
              );

              Navigator.pop(context);

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

              leading: const CircleAvatar(),

              title: Text(
                filteredStudents[index]['name'] ?? "",
              ),

              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "Email: ${filteredStudents[index]['email']}",
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