import 'dart:convert';

import 'package:flutter_w/model/task.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var isDark = false.obs;
  var search = "".obs;

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  void addTask(String title) {
    tasks.add(Task(
      title,
      date: DateTime.now().toString(),
    ));
    saveTasks();
  }

  void toggleDone(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks.refresh();
    saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }

  void editTask(int index, String newTitle) {
    tasks[index].title = newTitle;
    tasks.refresh();
    saveTasks();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
  }

  List<Task> get filteredTasks {
    if (search.value.isEmpty) return tasks;
    return tasks
        .where((e) =>
            e.title.toLowerCase().contains(search.value.toLowerCase()))
        .toList();
  }

  // ===== storage =====
  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "tasks", tasks.map((e) => jsonEncode(e.toJson())).toList());
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tasks");

    if (data != null) {
      tasks.value =
          data.map((e) => Task.fromJson(jsonDecode(e))).toList();
    }
  }
}
