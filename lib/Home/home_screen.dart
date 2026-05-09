import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/taskcontller.dart';

class HomePage extends StatelessWidget {
  final c = Get.put(TaskController());
  final txt = TextEditingController();

  void dialog({int? index}) {
    if (index != null) {
      txt.text = c.tasks[index].title;
    } else {
      txt.clear();
    }

    Get.defaultDialog(
      title: index == null ? "Add Task" : "Edit Task",
      content: TextField(controller: txt),
      onConfirm: () {
        if (txt.text.isNotEmpty) {
          index == null
              ? c.addTask(txt.text)
              : c.editTask(index, txt.text);
        }
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              c.isDark.value ? Colors.black : Colors.white,
          appBar: AppBar(
            title: Text("Task App", style: TextStyle(color: c.isDark.value ? Colors.white : const Color.fromARGB(255, 168, 11, 11))),
            backgroundColor: c.isDark.value ? Colors.grey[900] : Colors.grey[300],
            actions: [
              IconButton(
                icon: Icon(Icons.dark_mode),
                onPressed: c.toggleTheme,
              )
            ],
          ),
          body: Column(
            children: [
              // 🔍 Search
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (v) => c.search.value = v,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // 📋 List
              Expanded(
                child: ListView.builder(
                  itemCount: c.filteredTasks.length,
                  itemBuilder: (context, i) {
                    var task = c.filteredTasks[i];

                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isDone,
                          onChanged: (_) => c.toggleDone(i),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(task.date),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => dialog(index: i)),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => c.deleteTask(i)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => dialog(),
            child: Icon(Icons.add),
          ),
        ));
  }
}
