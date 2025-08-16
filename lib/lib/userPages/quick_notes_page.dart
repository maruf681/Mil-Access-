import 'package:flutter/material.dart';

class QuickNotesPage extends StatefulWidget {
  const QuickNotesPage({super.key});

  @override
  QuickNotesPageState createState() => QuickNotesPageState();
}

class QuickNotesPageState extends State<QuickNotesPage> {
  List<Note> notes = [
    Note(
      id: '1',
      title: 'Weekly Report',
      content: 'Prepare weekly operational report for Monday meeting',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isPinned: true,
      category: 'Work',
      priority: 'High',
    ),
    Note(
      id: '2',
      title: 'Training Schedule',
      content:
          'Combat training at 0800 hours, Equipment maintenance at 1400 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isPinned: false,
      category: 'Training',
      priority: 'Medium',
    ),
    Note(
      id: '3',
      title: 'Personal Reminder',
      content: 'Call family tonight after duty hours',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isPinned: false,
      category: 'Personal',
      priority: 'Low',
    ),
  ];

  String searchQuery = '';
  String selectedFilter = 'All';
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    List<Note> filteredNotes = _getFilteredNotes();

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? _buildSearchField()
            : const Text(
                'Quick Notes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        backgroundColor: const Color.fromARGB(255, 170, 242, 153),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  searchQuery = '';
                }
                isSearching = !isSearching;
              });
            },
          ),
          if (!isSearching)
            PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  selectedFilter = value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'All', child: Text('All Notes')),
                const PopupMenuItem(
                  value: 'Pinned',
                  child: Text('Pinned Only'),
                ),
                const PopupMenuItem(value: 'Work', child: Text('Work')),
                const PopupMenuItem(value: 'Training', child: Text('Training')),
                const PopupMenuItem(value: 'Personal', child: Text('Personal')),
                const PopupMenuItem(
                  value: 'High',
                  child: Text('High Priority'),
                ),
              ],
              icon: const Icon(Icons.filter_list),
            ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 170, 242, 153),
        child: Column(
          children: [
            // Filter chips
            if (!isSearching)
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip('All', Icons.note),
                    _buildFilterChip('Pinned', Icons.push_pin),
                    _buildFilterChip('Work', Icons.work),
                    _buildFilterChip('Training', Icons.school),
                    _buildFilterChip('Personal', Icons.person),
                    _buildFilterChip('High', Icons.priority_high),
                  ],
                ),
              ),

            // Quick Stats Card
            if (!isSearching && selectedFilter == 'All')
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickStat(
                      'Total',
                      notes.length.toString(),
                      Icons.note,
                      Colors.blue,
                    ),
                    _buildQuickStat(
                      'Pinned',
                      notes.where((n) => n.isPinned).length.toString(),
                      Icons.push_pin,
                      Colors.orange,
                    ),
                    _buildQuickStat(
                      'High Priority',
                      notes
                          .where((n) => n.priority == 'High')
                          .length
                          .toString(),
                      Icons.priority_high,
                      Colors.red,
                    ),
                  ],
                ),
              ),

            // Notes List
            Expanded(
              child: filteredNotes.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        return _buildEnhancedNoteCard(filteredNotes[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Quick add buttons
          if (notes.isNotEmpty)
            FloatingActionButton.small(
              onPressed: () => _quickAddNote('Meeting Notes'),
              backgroundColor: Colors.blue[700],
              heroTag: "quick_meeting",
              child: const Icon(
                Icons.meeting_room,
                color: Colors.white,
                size: 18,
              ),
            ),
          const SizedBox(height: 8),
          if (notes.isNotEmpty)
            FloatingActionButton.small(
              onPressed: () => _quickAddNote('Training Note'),
              backgroundColor: Colors.orange[700],
              heroTag: "quick_training",
              child: const Icon(Icons.school, color: Colors.white, size: 18),
            ),
          const SizedBox(height: 8),
          // Main add button
          FloatingActionButton(
            onPressed: () => _showEnhancedAddDialog(),
            backgroundColor: Colors.green[800],
            heroTag: "main_add",
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      autofocus: true,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(color: Colors.black54),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = selectedFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.green[800],
            ),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedFilter = selected ? label : 'All';
          });
        },
        selectedColor: Colors.green[800],
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.green[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              searchQuery.isNotEmpty || selectedFilter != 'All'
                  ? Icons.search_off
                  : Icons.note_add,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? 'No notes found for "$searchQuery"'
                : selectedFilter != 'All'
                ? 'No notes in $selectedFilter'
                : 'No notes yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first note',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedNoteCard(Note note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showNoteDetailsDialog(note),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(
                  color: _getPriorityColor(note.priority),
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (note.isPinned)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.push_pin,
                          size: 14,
                          color: Colors.orange,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildPriorityBadge(note.priority),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _togglePin(note),
                      child: Icon(
                        note.isPinned
                            ? Icons.push_pin
                            : Icons.push_pin_outlined,
                        size: 20,
                        color: note.isPinned ? Colors.orange : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      onSelected: (value) => _handleNoteAction(value, note),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'duplicate',
                          child: Row(
                            children: [
                              Icon(Icons.copy, size: 18),
                              SizedBox(width: 8),
                              Text('Duplicate'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  note.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          note.category,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getCategoryIcon(note.category),
                            size: 12,
                            color: _getCategoryColor(note.category),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            note.category,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getCategoryColor(note.category),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateTime(note.createdAt),
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = _getPriorityColor(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.blue;
      case 'training':
        return Colors.orange;
      case 'personal':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Icons.work;
      case 'training':
        return Icons.school;
      case 'personal':
        return Icons.person;
      default:
        return Icons.note;
    }
  }

  List<Note> _getFilteredNotes() {
    List<Note> filtered = notes;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((note) {
        return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by selected filter
    switch (selectedFilter) {
      case 'Pinned':
        filtered = filtered.where((note) => note.isPinned).toList();
        break;
      case 'Work':
      case 'Training':
      case 'Personal':
        filtered = filtered
            .where((note) => note.category == selectedFilter)
            .toList();
        break;
      case 'High':
        filtered = filtered.where((note) => note.priority == 'High').toList();
        break;
    }

    // Sort notes: pinned first, then by priority, then by date
    filtered.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;

      int priorityComparison = _getPriorityWeight(
        b.priority,
      ).compareTo(_getPriorityWeight(a.priority));
      if (priorityComparison != 0) return priorityComparison;

      return b.createdAt.compareTo(a.createdAt);
    });

    return filtered;
  }

  int _getPriorityWeight(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'low':
        return 1;
      default:
        return 0;
    }
  }

  void _quickAddNote(String template) {
    String title = '';
    String category = 'Work';

    if (template == 'Meeting Notes') {
      title = 'Meeting Notes - ${DateTime.now().day}/${DateTime.now().month}';
      category = 'Work';
    } else if (template == 'Training Note') {
      title =
          'Training Session - ${DateTime.now().day}/${DateTime.now().month}';
      category = 'Training';
    }

    setState(() {
      notes.add(
        Note(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: 'Add your notes here...',
          createdAt: DateTime.now(),
          isPinned: false,
          category: category,
          priority: 'Medium',
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Quick note created! Tap to edit.'),
        backgroundColor: Colors.green[800],
        action: SnackBarAction(
          label: 'Edit',
          textColor: Colors.white,
          onPressed: () {
            _showEnhancedEditDialog(notes.last);
          },
        ),
      ),
    );
  }

  void _handleNoteAction(String action, Note note) {
    switch (action) {
      case 'edit':
        _showEnhancedEditDialog(note);
        break;
      case 'duplicate':
        _duplicateNote(note);
        break;
      case 'delete':
        _showDeleteConfirmation(note);
        break;
    }
  }

  void _duplicateNote(Note note) {
    setState(() {
      notes.add(
        Note(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: '${note.title} (Copy)',
          content: note.content,
          createdAt: DateTime.now(),
          isPinned: false,
          category: note.category,
          priority: note.priority,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note duplicated successfully!'),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  void _togglePin(Note note) {
    setState(() {
      note.isPinned = !note.isPinned;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(note.isPinned ? 'Note pinned' : 'Note unpinned'),
        backgroundColor: Colors.green[800],
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showEnhancedAddDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    String selectedCategory = 'Work';
    String selectedPriority = 'Medium';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(Icons.note_add, color: Colors.green[800]),
                  const SizedBox(width: 8),
                  const Text('Add New Note'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCategory,
                            decoration: InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.category),
                            ),
                            items: ['Work', 'Training', 'Personal', 'Other']
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setDialogState(() {
                                selectedCategory = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedPriority,
                            decoration: InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.priority_high),
                            ),
                            items: ['High', 'Medium', 'Low']
                                .map(
                                  (priority) => DropdownMenuItem(
                                    value: priority,
                                    child: Text(priority),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setDialogState(() {
                                selectedPriority = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty) {
                      setState(() {
                        notes.add(
                          Note(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: titleController.text,
                            content: contentController.text,
                            createdAt: DateTime.now(),
                            isPinned: false,
                            category: selectedCategory,
                            priority: selectedPriority,
                          ),
                        );
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Note created successfully!'),
                          backgroundColor: Colors.green[800],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add Note'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEnhancedEditDialog(Note note) {
    TextEditingController titleController = TextEditingController(
      text: note.title,
    );
    TextEditingController contentController = TextEditingController(
      text: note.content,
    );
    String selectedCategory = note.category;
    String selectedPriority = note.priority;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(Icons.edit, color: Colors.green[800]),
                  const SizedBox(width: 8),
                  const Text('Edit Note'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCategory,
                            decoration: InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.category),
                            ),
                            items: ['Work', 'Training', 'Personal', 'Other']
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setDialogState(() {
                                selectedCategory = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedPriority,
                            decoration: InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.priority_high),
                            ),
                            items: ['High', 'Medium', 'Low']
                                .map(
                                  (priority) => DropdownMenuItem(
                                    value: priority,
                                    child: Text(priority),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setDialogState(() {
                                selectedPriority = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty) {
                      setState(() {
                        note.title = titleController.text;
                        note.content = contentController.text;
                        note.category = selectedCategory;
                        note.priority = selectedPriority;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Note updated successfully!'),
                          backgroundColor: Colors.green[800],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showNoteDetailsDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              if (note.isPinned)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.push_pin,
                    size: 16,
                    color: Colors.orange,
                  ),
                ),
              Expanded(
                child: Text(note.title, style: const TextStyle(fontSize: 18)),
              ),
              _buildPriorityBadge(note.priority),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    note.content,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          note.category,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getCategoryIcon(note.category),
                            size: 14,
                            color: _getCategoryColor(note.category),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            note.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(note.category),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Created: ${_formatDateTime(note.createdAt)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showEnhancedEditDialog(note);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete Note'),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${note.title}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notes.removeWhere((n) => n.id == note.id);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Note deleted successfully!'),
                      ],
                    ),
                    backgroundColor: Colors.red[800],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  bool isPinned;
  String category;
  String priority;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.isPinned,
    required this.category,
    required this.priority,
  });
}
