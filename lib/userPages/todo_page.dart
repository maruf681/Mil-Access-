import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// # MODELS
// =================================================================================================
class TodoItem {
  String id;
  String title;
  DateTime dueDate;
  TimeOfDay time;
  String category;
  String type;
  bool isDone;

  TodoItem({
    String? id,
    required this.title,
    required this.dueDate,
    required this.time,
    required this.category,
    required this.type,
    this.isDone = false,
  }) : id = id ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'dueDate': dueDate.toIso8601String(),
    'timeHour': time.hour,
    'timeMinute': time.minute,
    'category': category,
    'type': type,
    'isDone': isDone,
  };

  static TodoItem fromJson(Map<String, dynamic> json) => TodoItem(
    id: json['id'],
    title: json['title'],
    dueDate: DateTime.parse(json['dueDate']),
    time: TimeOfDay(hour: json['timeHour'], minute: json['timeMinute']),
    category: json['category'],
    type: json['type'],
    isDone: json['isDone'],
  );
}

// # WIDGETS
// =================================================================================================
class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoItem> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> jsonList = jsonDecode(tasksJson);
      setState(() {
        tasks = jsonList.map((item) => TodoItem.fromJson(item)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = tasks
        .map((item) => item.toJson())
        .toList();
    await prefs.setString('tasks', jsonEncode(jsonList));
  }

  void _showTodoDialog({TodoItem? task}) {
    final isEditing = task != null;
    final titleController = TextEditingController(text: task?.title);
    DateTime? selectedDate = task?.dueDate;
    TimeOfDay? selectedTime = task?.time;
    String? selectedCategory = task?.category;
    String? selectedType = task?.type;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEditing ? 'Edit Task' : 'Add Task',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Task Title'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              selectedDate == null
                                  ? 'Pick Due Date'
                                  : '${selectedDate!.toLocal()}'.split(' ')[0],
                            ),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              setState(() => selectedDate = picked);
                                                        },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.access_time),
                            label: Text(
                              selectedTime == null
                                  ? 'Pick Time'
                                  : selectedTime!.format(context),
                            ),
                            onPressed: () async {
                              TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime ?? TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() => selectedTime = picked);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(labelText: "Category"),
                      items: ['Training', 'Medical', 'Logistics', 'Admin']
                          .map(
                            (category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedCategory = value),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(labelText: "Type"),
                      items: ['Urgent', 'Routine', 'Optional']
                          .map(
                            (type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedType = value),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Text(isEditing ? "Update Task" : "Save Task"),
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            selectedDate == null ||
                            selectedTime == null ||
                            selectedCategory == null ||
                            selectedType == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all fields."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (isEditing) {
                          final index = tasks.indexWhere(
                            (element) => element.id == task.id,
                          );
                          if (index != -1) {
                            setState(() {
                              tasks[index] = TodoItem(
                                id: task.id,
                                title: titleController.text,
                                dueDate: selectedDate!,
                                time: selectedTime!,
                                category: selectedCategory!,
                                type: selectedType!,
                                isDone: task.isDone,
                              );
                            });
                          }
                        } else {
                          final newTask = TodoItem(
                            title: titleController.text,
                            dueDate: selectedDate!,
                            time: selectedTime!,
                            category: selectedCategory!,
                            type: selectedType!,
                          );
                          setState(() => tasks.add(newTask));
                        }

                        _saveTasks();
                        Navigator.of(ctx).pop();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
    _saveTasks();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task deleted."), backgroundColor: Colors.green),
    );
  }

  Widget _buildTaskCard(TodoItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: Checkbox(
          value: item.isDone,
          onChanged: (value) {
            setState(() => item.isDone = value!);
            _saveTasks();
          },
        ),
        title: Text(
          item.title,
          style: TextStyle(
            decoration: item.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Due: ${item.dueDate.toLocal().toString().split(' ')[0]}, Time: ${item.time.format(context)}\nCategory: ${item.category} | Type: ${item.type}',
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              _showTodoDialog(task: item);
            } else if (value == 'delete') {
              _deleteTask(item.id);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
            const PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List"), centerTitle: true),
      body: tasks.isEmpty
          ? const Center(child: Text("No tasks added yet."))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, i) => _buildTaskCard(tasks[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
