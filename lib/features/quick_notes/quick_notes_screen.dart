import 'package:flutter/material.dart';

// Data model for a Quick Note item
class Note { // Renamed from CoTodoItem
  String task; // Renamed from task to content for clarity as notes
  bool isCompleted; // Kept for potential future use or if a note can be "completed"

  Note({required this.task, this.isCompleted = false});
}

class QuickNotesScreen extends StatefulWidget { // Renamed from CoToDoListScreen
  const QuickNotesScreen({super.key});

  @override
  State<QuickNotesScreen> createState() => _QuickNotesScreenState(); // Renamed state class
}

class _QuickNotesScreenState extends State<QuickNotesScreen> { // Renamed state class
  final TextEditingController _noteController = TextEditingController(); // Renamed from _taskController
  final List<Note> _notesList = []; // Renamed from _todoList

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() { // Renamed from _addTask
    if (_noteController.text.isNotEmpty) {
      setState(() {
        _notesList.add(Note(task: _noteController.text)); // Using 'task' as content
        _noteController.clear(); // Clear the text field after adding
      });
    } else {
      _showMessageBox(context, 'Empty Note', 'Please enter a note before adding.');
    }
  }

  void _toggleNoteCompletion(int index) { // Renamed from _toggleTaskCompletion
    setState(() {
      _notesList[index].isCompleted = !_notesList[index].isCompleted;
    });
  }

  void _deleteNote(int index) { // Renamed from _deleteTask
    setState(() {
      final String noteContent = _notesList[index].task; // Using 'task' as content
      _notesList.removeAt(index);
      _showMessageBox(context, 'Note Deleted', 'Note "$noteContent" has been removed.');
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
        title: const Text('Quick Notes'), // Updated title
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
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: 'Add a new quick note...', // Updated hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    onSubmitted: (value) => _addNote(), // Add note on pressing enter
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addNote,
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
            child: _notesList.isEmpty
                ? const Center(
                    child: Text(
                      'No notes added yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _notesList.length,
                    itemBuilder: (context, index) {
                      final note = _notesList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: note.isCompleted,
                            onChanged: (bool? newValue) {
                              _toggleNoteCompletion(index);
                            },
                            activeColor: Colors.green[700],
                          ),
                          title: Text(
                            note.task, // Display note content
                            style: TextStyle(
                              decoration: note.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              color: note.isCompleted ? Colors.grey : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNote(index),
                          ),
                          onTap: () => _toggleNoteCompletion(index), // Tap to toggle completion
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

