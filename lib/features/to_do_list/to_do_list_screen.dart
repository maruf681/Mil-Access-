import 'package:flutter/material.dart';

// Data model for a To Do item
class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final List<TodoItem> _todoList = []; // In-memory list of tasks

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _todoList.add(TodoItem(task: _taskController.text));
        _taskController.clear(); // Clear the text field after adding
      });
    } else {
      _showMessageBox(context, 'Empty Task', 'Please enter a task before adding.');
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      final String taskTitle = _todoList[index].task;
      _todoList.removeAt(index);
      _showMessageBox(context, 'Task Deleted', 'Task "$taskTitle" has been removed.');
    });
  }

  void _showMessageBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CO\'s To Do List'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task for under commands...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    onSubmitted: (value) => _addTask(), // Add task on pressing enter
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: _todoList.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks added yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      final todo = _todoList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (bool? newValue) {
                              _toggleTaskCompletion(index);
                            },
                            activeColor: Colors.green[700],
                          ),
                          title: Text(
                            todo.task,
                            style: TextStyle(
                              decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              color: todo.isCompleted ? Colors.grey : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(index),
                          ),
                          onTap: () => _toggleTaskCompletion(index), // Tap to toggle completion
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

