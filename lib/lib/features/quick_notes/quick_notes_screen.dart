import 'package:flutter/material.dart';

// Enhanced Note model similar to Samsung Notes
class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;
  Color color;
  bool isPinned;
  String category;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
    this.color = Colors.white,
    this.isPinned = false,
    this.category = 'Operations',
  });
}

class QuickNotesScreen extends StatefulWidget {
  const QuickNotesScreen({super.key});

  @override
  State<QuickNotesScreen> createState() => _QuickNotesScreenState();
}

class _QuickNotesScreenState extends State<QuickNotesScreen> {
  final List<Note> _notesList = [];
  bool _isGridView = true; // Default to grid view like your home screen
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Operations',
    'Personnel',
    'Training',
    'Logistics',
    'Command'
  ];
  final List<Color> _noteColors = [
    Colors.white,
    const Color(0xFFFFF9C4), // Light yellow
    const Color(0xFFE1F5FE), // Light blue
    const Color(0xFFE8F5E8), // Light green
    const Color(0xFFFCE4EC), // Light pink
    const Color(0xFFFFF3E0), // Light orange
  ];

  @override
  void initState() {
    super.initState();
    _addSampleNotes();
  }

  void _addSampleNotes() {
    _notesList.addAll([
      Note(
        id: '1',
        title: 'Daily Brief - Unit Status',
        content:
            'Personnel Strength: 245/250\nVehicle Readiness: 92%\nTraining Schedule: Combat Readiness Exercise 0800\nSecurity Status: FPCON Bravo\nWeather Impact: Training continues as planned',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        modifiedAt: DateTime.now().subtract(const Duration(hours: 2)),
        color: const Color(0xFFFFF9C4),
        category: 'Operations',
        isPinned: true,
      ),
      Note(
        id: '2',
        title: 'Personnel Deployment Orders',
        content:
            'Alpha Company - Forward Operating Base deployment\nBravo Company - Base security detail\nCharlie Company - Training rotation\nDelta Company - Equipment maintenance\n\nDeployment Date: 15 Aug 2024\nDuration: 6 months',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        modifiedAt: DateTime.now().subtract(const Duration(days: 1)),
        color: const Color(0xFFE1F5FE),
        category: 'Operations',
        isPinned: true,
      ),
      Note(
        id: '3',
        title: 'Equipment Inspection Report',
        content:
            'M4 Rifles: 98% serviceable\nBody Armor: All units inspected and certified\nCommunication Equipment: 2 radios require maintenance\nVehicles: 3 HMMWVs scheduled for service\n\nNext Inspection: 30 July 2024',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        modifiedAt: DateTime.now().subtract(const Duration(hours: 6)),
        color: const Color(0xFFE8F5E8),
        category: 'Logistics',
      ),
      Note(
        id: '4',
        title: 'Training Exercise Debrief',
        content:
            'Operation Desert Storm Simulation\n\nStrengths:\n- Excellent communication\n- Quick response time\n- Good tactical positioning\n\nAreas for Improvement:\n- Supply chain coordination\n- Night vision operations\n\nNext Training: Live Fire Exercise',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        modifiedAt: DateTime.now().subtract(const Duration(days: 2)),
        color: const Color(0xFFFCE4EC),
        category: 'Training',
      ),
      Note(
        id: '5',
        title: 'Command Priorities',
        content:
            'Week 30 Focus Areas:\n\n1. Enhance unit readiness to 95%\n2. Complete NCO professional development\n3. Finalize deployment preparations\n4. Conduct safety briefings\n5. Review and update SOPs\n\nCommander\'s Intent: Mission Ready Force',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        modifiedAt: DateTime.now().subtract(const Duration(hours: 1)),
        color: const Color(0xFFFFF3E0),
        category: 'Command',
        isPinned: true,
      ),
      Note(
        id: '6',
        title: 'Awards & Recognition',
        content:
            'Soldier of the Month: SGT Johnson, A.\nUnit Citation: Meritorious Service during Exercise\nCommendations Pending:\n- CPL Martinez (Leadership)\n- SPC Davis (Technical Excellence)\n\nCeremony Date: 5 August 2024',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        modifiedAt: DateTime.now().subtract(const Duration(days: 4)),
        color: const Color(0xFFE8F5E8),
        category: 'Personnel',
      ),
    ]);
  }

  void _createNewNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          onSave: (title, content, color, category) {
            setState(() {
              _notesList.insert(
                  0,
                  Note(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title.isEmpty ? 'Untitled' : title,
                    content: content,
                    createdAt: DateTime.now(),
                    modifiedAt: DateTime.now(),
                    color: color,
                    category: category,
                  ));
            });
          },
        ),
      ),
    );
  }

  void _editNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          note: note,
          onSave: (title, content, color, category) {
            setState(() {
              note.title = title.isEmpty ? 'Untitled' : title;
              note.content = content;
              note.modifiedAt = DateTime.now();
              note.color = color;
              note.category = category;
            });
          },
          onDelete: () {
            setState(() {
              _notesList.remove(note);
            });
            _showSnackBar('Note deleted');
          },
        ),
      ),
    );
  }

  void _togglePin(Note note) {
    setState(() {
      note.isPinned = !note.isPinned;
      note.modifiedAt = DateTime.now();
      // Reorder: pinned notes first
      _notesList.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.modifiedAt.compareTo(a.modifiedAt);
      });
    });
    _showSnackBar(note.isPinned ? 'Note pinned' : 'Note unpinned');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  List<Note> get _filteredNotes {
    List<Note> filtered = _selectedCategory == 'All'
        ? _notesList
        : _notesList.where((note) => note.category == _selectedCategory).toList();

    // Sort: pinned first, then by modified date
    filtered.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.modifiedAt.compareTo(a.modifiedAt);
    });

    return filtered;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      margin: EdgeInsets.all(_isGridView ? 4 : 8),
      color: note.color,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _editNote(note),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with title and menu
              Row(
                children: [
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
                  if (note.isPinned)
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.push_pin,
                        size: 16,
                        color: Colors.green[700],
                      ),
                    ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'pin':
                          _togglePin(note);
                          break;
                        case 'delete':
                          _showDeleteDialog(note);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(
                              note.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                              color: Colors.green[700],
                            ),
                            const SizedBox(width: 8),
                            Text(note.isPinned ? 'Unpin' : 'Pin'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Content preview
              if (note.content.isNotEmpty)
                Text(
                  note.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.3,
                  ),
                  maxLines: _isGridView ? 4 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),
              // Footer with category and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCEDC8), // Matching your app's light green
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      note.category,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    _formatDate(note.modifiedAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: Text('Are you sure you want to delete "${note.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _notesList.remove(note);
                });
                Navigator.of(context).pop();
                _showSnackBar('Note deleted');
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
              Icons.note_add,
              size: 64,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the + button to create your first note',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    final filteredNotes = _filteredNotes;

    if (filteredNotes.isEmpty) {
      return _buildEmptyState();
    }

    if (_isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) => _buildNoteCard(filteredNotes[index]),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) => _buildNoteCard(filteredNotes[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quick Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700], // Matching your app's color
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              _showSnackBar('Search feature coming soon!');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filter bar
          Container(
            height: 60,
            color: const Color(0xFFE6F2E6), // Matching your app's background
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.green[700],
                        fontWeight: FontWeight.w500,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: _buildNotesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewNote,
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

// Note Editor Screen
class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  final Function(String title, String content, Color color, String category) onSave;
  final VoidCallback? onDelete;

  const NoteEditorScreen({
    super.key,
    this.note,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Color _selectedColor;
  late String _selectedCategory;
  bool _hasChanges = false;

  final List<String> _categories = [
    'Operations',
    'Personnel',
    'Training',
    'Logistics',
    'Command'
  ];
  final List<Color> _noteColors = [
    Colors.white,
    const Color(0xFFFFF9C4), // Light yellow
    const Color(0xFFE1F5FE), // Light blue
    const Color(0xFFE8F5E8), // Light green
    const Color(0xFFFCE4EC), // Light pink
    const Color(0xFFFFF3E0), // Light orange
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedColor = widget.note?.color ?? Colors.white;
    _selectedCategory = widget.note?.category ?? 'Operations';

    // Listen for changes
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    // Only save if there's content or title, or if it's an existing note being modified
    if (_titleController.text.trim().isNotEmpty ||
        _contentController.text.trim().isNotEmpty ||
        widget.note != null) {
      widget.onSave(
        _titleController.text.trim(),
        _contentController.text.trim(),
        _selectedColor,
        _selectedCategory,
      );
    }
    Navigator.pop(context);
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _noteColors.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                  _hasChanges = true;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey[300]!,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Colors.green[700], size: 24)
                    : null,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _categories.map((category) {
            return RadioListTile<String>(
              title: Text(category),
              value: category,
              groupValue: _selectedCategory,
              activeColor: Colors.green[700],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                  _hasChanges = true;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // Automatically save if there are changes or content/title is not empty
    if (_hasChanges ||
        _titleController.text.trim().isNotEmpty ||
        _contentController.text.trim().isNotEmpty) {
      _saveNote();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: _selectedColor,
        appBar: AppBar(
          backgroundColor: _selectedColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            // Save button
            if (_hasChanges || widget.note == null) // Show save for new notes or notes with changes
              IconButton(
                icon: const Icon(Icons.save, color: Colors.black87),
                onPressed: _saveNote,
              ),
            IconButton(
              icon: const Icon(Icons.palette, color: Colors.black87),
              onPressed: _showColorPicker,
            ),
            IconButton(
              icon: const Icon(Icons.category, color: Colors.black87),
              onPressed: _showCategoryPicker,
            ),
            if (widget.onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note'),
                      content: const Text('Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.onDelete!();
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Close editor
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Title input
              TextField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Note title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 8),
              // Category and date info
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCEDC8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _selectedCategory,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.note != null
                        ? 'Modified ${DateTime.now().day}/${DateTime.now().month}'
                        : 'New note',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Content input
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                  decoration: const InputDecoration(
                    hintText: 'Start writing your note...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}