import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  var tasks = [].obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void addTask(String title) async {
    await firestore.collection("tasks").add({
      "title": title,
      "uid": auth.currentUser!.uid,
      "time": DateTime.now()
    });
  }

  void fetchTasks() {
    firestore
        .collection("tasks")
        .where("uid", isEqualTo: auth.currentUser?.uid)
        .snapshots()
        .listen((snapshot) {
      tasks.value = snapshot.docs;
    });
  }

  void deleteTask(String id) {
    firestore.collection("tasks").doc(id).delete();
  }
}
