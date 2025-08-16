import 'package:flutter/material.dart';

// Enhanced military task model
class MilitaryTask {
  String id;
  String task;
  String assignedTo;
  String priority; // HIGH, MEDIUM, LOW
  String category; // OPERATIONS, LOGISTICS, PERSONNEL, TRAINING, ADMIN
  DateTime createdAt;
  DateTime? dueDate;
  bool isCompleted;
  String? notes;
  bool isOverdue;

  MilitaryTask({
    required this.id,
    required this.task,
    required this.assignedTo,
    required this.priority,
    required this.category,
    required this.createdAt,
    this.dueDate,
    this.isCompleted = false,
    this.notes,
  }) : isOverdue = false {
    updateOverdueStatus();
  }

  void updateOverdueStatus() {
    if (dueDate != null && !isCompleted) {
      final now = DateTime.now();
      final dueEndOfDay = DateTime(dueDate!.year, dueDate!.month, dueDate!.day, 23, 59, 59);
      isOverdue = now.isAfter(dueEndOfDay);
    } else {
      isOverdue = false;
    }
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> with TickerProviderStateMixin {
  final List<MilitaryTask> _militaryTasks = [];
  String _selectedFilter = 'ALL'; // ALL, PENDING, COMPLETED, OVERDUE
  String _selectedCategory = 'ALL';
  late TabController _tabController;

  final List<String> _officers = [
    'Adjutant',
    'Quartermaster', 
    'Operations Officer',
    'Personnel Officer',
    'Training Officer',
    'Intelligence Officer',
    'Communications Officer',
    'Medical Officer'
  ];

  final List<String> _categories = [
    'OPERATIONS',
    'LOGISTICS', 
    'PERSONNEL',
    'TRAINING',
    'ADMIN'
  ];

  final List<String> _priorities = ['HIGH', 'MEDIUM', 'LOW'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _addSampleTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addSampleTasks() {
    final now = DateTime.now();
    _militaryTasks.addAll([
      MilitaryTask(
        id: '1',
        task: 'Prepare weekly personnel strength report',
        assignedTo: 'Adjutant',
        priority: 'HIGH',
        category: 'PERSONNEL',
        createdAt: now.subtract(const Duration(days: 2)),
        dueDate: DateTime(now.year, now.month, now.day + 1), // Tomorrow
        notes: 'Include deployment readiness status',
      ),
      MilitaryTask(
        id: '2',
        task: 'Coordinate ammunition inventory audit',
        assignedTo: 'Quartermaster',
        priority: 'HIGH',
        category: 'LOGISTICS',
        createdAt: now.subtract(const Duration(days: 1)),
        dueDate: DateTime(now.year, now.month, now.day - 1), // Yesterday - will be overdue
        notes: 'Focus on Class V supplies',
      ),
      MilitaryTask(
        id: '3',
        task: 'Schedule combat readiness training',
        assignedTo: 'Training Officer',
        priority: 'MEDIUM',
        category: 'TRAINING',
        createdAt: now.subtract(const Duration(hours: 6)),
        dueDate: DateTime(now.year, now.month, now.day + 3), // 3 days from now
      ),
      MilitaryTask(
        id: '4',
        task: 'Update unit operational plans',
        assignedTo: 'Operations Officer',
        priority: 'HIGH',
        category: 'OPERATIONS',
        createdAt: now.subtract(const Duration(days: 3)),
        dueDate: DateTime(now.year, now.month, now.day + 2), // 2 days from now
        isCompleted: true,
      ),
      MilitaryTask(
        id: '5',
        task: 'Process leave requests for August',
        assignedTo: 'Personnel Officer',
        priority: 'MEDIUM',
        category: 'PERSONNEL',
        createdAt: now.subtract(const Duration(hours: 4)),
        dueDate: DateTime(now.year, now.month, now.day + 5), // 5 days from now
      ),
    ]);
    
    // Update overdue status for all tasks
    for (var task in _militaryTasks) {
      task.updateOverdueStatus();
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        officers: _officers,
        categories: _categories,
        priorities: _priorities,
        onTaskAdded: (task) {
          setState(() {
            _militaryTasks.insert(0, task);
          });
          _showSnackBar('Task assigned to ${task.assignedTo}');
        },
      ),
    );
  }

  void _showEditTaskDialog(MilitaryTask task) {
    showDialog(
      context: context,
      builder: (context) => EditTaskDialog(
        task: task,
        officers: _officers,
        categories: _categories,
        priorities: _priorities,
        onTaskUpdated: (updatedTask) {
          setState(() {
            final index = _militaryTasks.indexWhere((t) => t.id == task.id);
            if (index != -1) {
              _militaryTasks[index] = updatedTask;
            }
          });
          _showSnackBar('Task updated');
        },
        onTaskDeleted: () {
          setState(() {
            _militaryTasks.removeWhere((t) => t.id == task.id);
          });
          _showSnackBar('Task deleted');
        },
      ),
    );
  }

  void _toggleTaskCompletion(MilitaryTask task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      task.updateOverdueStatus();
    });
    
    if (task.isCompleted) {
      _showSnackBar('Task completed! ${task.assignedTo} notified.');
    } else {
      _showSnackBar('Task marked as pending');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green[700],
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  List<MilitaryTask> get _filteredTasks {
    List<MilitaryTask> filtered = List.from(_militaryTasks);
    
    // Filter by completion status
    switch (_selectedFilter) {
      case 'PENDING':
        filtered = filtered.where((task) => !task.isCompleted).toList();
        break;
      case 'COMPLETED':
        filtered = filtered.where((task) => task.isCompleted).toList();
        break;
      case 'OVERDUE':
        filtered = filtered.where((task) => task.isOverdue).toList();
        break;
    }
    
    // Filter by category
    if (_selectedCategory != 'ALL') {
      filtered = filtered.where((task) => task.category == _selectedCategory).toList();
    }
    
    // Sort by priority and due date
    filtered.sort((a, b) {
      // Overdue tasks first
      if (a.isOverdue && !b.isOverdue) return -1;
      if (!a.isOverdue && b.isOverdue) return 1;
      
      // Then by priority
      const priorityOrder = {'HIGH': 0, 'MEDIUM': 1, 'LOW': 2};
      final priorityCompare = priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
      if (priorityCompare != 0) return priorityCompare;
      
      // Then by due date
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }
      if (a.dueDate != null) return -1;
      if (b.dueDate != null) return 1;
      
      // Finally by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });
    
    return filtered;
  }

  int get _pendingCount => _militaryTasks.where((task) => !task.isCompleted).length;
  int get _completedCount => _militaryTasks.where((task) => task.isCompleted).length;
  int get _overdueCount => _militaryTasks.where((task) => task.isOverdue).length;
  int get _highPriorityCount => _militaryTasks.where((task) => task.priority == 'HIGH' && !task.isCompleted).length;

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'HIGH': return Colors.red;
      case 'MEDIUM': return Colors.orange;
      case 'LOW': return Colors.blue;
      default: return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No due date';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(date.year, date.month, date.day);
    final difference = dueDay.difference(today).inDays;
    
    if (difference == 0) return 'Due today';
    if (difference == 1) return 'Due tomorrow';
    if (difference > 1) return 'Due in $difference days';
    if (difference == -1) return '1 day overdue';
    return '${-difference} days overdue';
  }

  Widget _buildTaskCard(MilitaryTask task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: task.isOverdue ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: task.isOverdue 
            ? const BorderSide(color: Colors.red, width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _showEditTaskDialog(task),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with priority and completion checkbox
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(task.priority),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.priority,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCEDC8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.category,
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (task.isOverdue)
                    const Icon(Icons.warning, color: Colors.red, size: 20),
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => _toggleTaskCompletion(task),
                    activeColor: Colors.green[700],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Task title
              Text(
                task.task,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: task.isCompleted 
                      ? TextDecoration.lineThrough 
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              
              // Assigned to and due date
              Row(
                children: [
                  Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    task.assignedTo,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: task.isOverdue ? Colors.red : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(task.dueDate),
                    style: TextStyle(
                      fontSize: 13,
                      color: task.isOverdue ? Colors.red : Colors.grey[600],
                      fontWeight: task.isOverdue ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              
              // Notes if available
              if (task.notes != null && task.notes!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.note_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          task.notes!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildStatCard('Pending', _pendingCount.toString(), Colors.orange, Icons.pending_actions),
          _buildStatCard('Completed', _completedCount.toString(), Colors.green, Icons.check_circle),
          _buildStatCard('Overdue', _overdueCount.toString(), Colors.red, Icons.warning),
          _buildStatCard('High Priority', _highPriorityCount.toString(), Colors.red[700]!, Icons.priority_high),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color, IconData icon) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _filteredTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CO\'s Task Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                if (_overdueCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        _overdueCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              setState(() {
                _selectedFilter = 'OVERDUE';
              });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0: _selectedFilter = 'ALL'; break;
                case 1: _selectedFilter = 'PENDING'; break;
                case 2: _selectedFilter = 'COMPLETED'; break;
                case 3: _selectedFilter = 'OVERDUE'; break;
              }
            });
          },
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
            Tab(text: 'Overdue'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildStatsCards(),
          
          // Category filter
          Container(
            height: 50,
            color: const Color(0xFFE6F2E6),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: ['ALL', ..._categories].length,
              itemBuilder: (context, index) {
                final category = ['ALL', ..._categories][index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.green[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.green[700],
                    backgroundColor: Colors.white,
                    elevation: isSelected ? 3 : 1,
                  ),
                );
              },
            ),
          ),
          
          // Tasks list
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCEDC8),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedFilter == 'ALL' ? 'No tasks assigned yet' : 'No ${_selectedFilter.toLowerCase()} tasks',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap + to assign a new task',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 80),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) => _buildTaskCard(filteredTasks[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.green[700],
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Assign Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Add Task Dialog
class AddTaskDialog extends StatefulWidget {
  final List<String> officers;
  final List<String> categories;
  final List<String> priorities;
  final Function(MilitaryTask) onTaskAdded;

  const AddTaskDialog({
    super.key,
    required this.officers,
    required this.categories,
    required this.priorities,
    required this.onTaskAdded,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _taskController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedOfficer = '';
  String _selectedCategory = '';
  String _selectedPriority = 'MEDIUM';
  DateTime? _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _selectedOfficer = widget.officers.first;
    _selectedCategory = widget.categories.first;
  }

  @override
  void dispose() {
    _taskController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDueDate = date;
      });
    }
  }

  void _addTask() {
    if (_taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task description')),
      );
      return;
    }

    final task = MilitaryTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      task: _taskController.text.trim(),
      assignedTo: _selectedOfficer,
      priority: _selectedPriority,
      category: _selectedCategory,
      createdAt: DateTime.now(),
      dueDate: _selectedDueDate,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    widget.onTaskAdded(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assign New Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                hintText: 'Enter task details...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedOfficer,
              decoration: const InputDecoration(
                labelText: 'Assign To',
                border: OutlineInputBorder(),
              ),
              items: widget.officers.map((officer) {
                return DropdownMenuItem(value: officer, child: Text(officer));
              }).toList(),
              onChanged: (value) => setState(() => _selectedOfficer = value!),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.categories.map((category) {
                      return DropdownMenuItem(value: category, child: Text(category));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.priorities.map((priority) {
                      return DropdownMenuItem(value: priority, child: Text(priority));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedPriority = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            InkWell(
              onTap: _selectDueDate,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(
                      _selectedDueDate != null
                          ? 'Due: ${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                          : 'Set Due Date (Optional)',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                hintText: 'Add any special instructions...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Assign Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Task Dialog
class EditTaskDialog extends StatefulWidget {
  final MilitaryTask task;
  final List<String> officers;
  final List<String> categories;
  final List<String> priorities;
  final Function(MilitaryTask) onTaskUpdated;
  final VoidCallback onTaskDeleted;

  const EditTaskDialog({
    super.key,
    required this.task,
    required this.officers,
    required this.categories,
    required this.priorities,
    required this.onTaskUpdated,
    required this.onTaskDeleted,
  });

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _taskController;
  late TextEditingController _notesController;
  late String _selectedOfficer;
  late String _selectedCategory;
  late String _selectedPriority;
  DateTime? _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task.task);
    _notesController = TextEditingController(text: widget.task.notes ?? '');
    _selectedOfficer = widget.task.assignedTo;
    _selectedCategory = widget.task.category;
    _selectedPriority = widget.task.priority;
    _selectedDueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _taskController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDueDate = date;
      });
    }
  }

  void _updateTask() {
    if (_taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task description')),
      );
      return;
    }

    final updatedTask = MilitaryTask(
      id: widget.task.id,
      task: _taskController.text.trim(),
      assignedTo: _selectedOfficer,
      priority: _selectedPriority,
      category: _selectedCategory,
      createdAt: widget.task.createdAt,
      dueDate: _selectedDueDate,
      isCompleted: widget.task.isCompleted,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    widget.onTaskUpdated(updatedTask);
    Navigator.pop(context);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close edit dialog
              widget.onTaskDeleted();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _confirmDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete Task',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedOfficer,
              decoration: const InputDecoration(
                labelText: 'Assign To',
                border: OutlineInputBorder(),
              ),
              items: widget.officers.map((officer) {
                return DropdownMenuItem(value: officer, child: Text(officer));
              }).toList(),
              onChanged: (value) => setState(() => _selectedOfficer = value!),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.categories.map((category) {
                      return DropdownMenuItem(value: category, child: Text(category));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.priorities.map((priority) {
                      return DropdownMenuItem(value: priority, child: Text(priority));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedPriority = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            InkWell(
              onTap: _selectDueDate,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedDueDate != null
                            ? 'Due: ${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                            : 'Set Due Date (Optional)',
                      ),
                    ),
                    if (_selectedDueDate != null)
                      IconButton(
                        onPressed: () => setState(() => _selectedDueDate = null),
                        icon: const Icon(Icons.clear, size: 20),
                        tooltip: 'Remove due date',
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _updateTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Update Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}