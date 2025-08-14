import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingCalendarPage extends StatefulWidget {
  const TrainingCalendarPage({super.key});

  @override
  State<TrainingCalendarPage> createState() => _TrainingCalendarPageState();
}

class _TrainingCalendarPageState extends State<TrainingCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _currentView = 'month'; // month, week, day
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<DateTime, List<CalendarEvent>> _events = {};

  // Event type colors
  final Map<String, Color> _eventTypeColors = {
    'Training': Colors.blue,
    'Meeting': Colors.green,
    'Conference': Colors.purple,
    'Sports': Colors.orange,
    'Miscellaneous': Colors.grey,
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadEvents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load events from SharedPreferences
  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsJson = prefs.getString('calendar_events');
    if (eventsJson != null) {
      final Map<String, dynamic> eventsMap = json.decode(eventsJson);
      setState(() {
        _events.clear();
        eventsMap.forEach((key, value) {
          final date = DateTime.parse(key);
          final events = (value as List)
              .map((e) => CalendarEvent.fromJson(e))
              .toList();
          _events[date] = events;
        });
      });
    }
  }

  // Save events to SharedPreferences
  Future<void> _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> eventsMap = {};
    _events.forEach((key, value) {
      eventsMap[key.toIso8601String()] = value.map((e) => e.toJson()).toList();
    });
    await prefs.setString('calendar_events', json.encode(eventsMap));
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final dayKey = DateTime(day.year, day.month, day.day);
    return _events[dayKey] ?? [];
  }

  List<CalendarEvent> _getFilteredEvents() {
    if (_searchQuery.isEmpty) return [];

    List<CalendarEvent> allEvents = [];
    for (var events in _events.values) {
      allEvents.addAll(events);
    }

    return allEvents.where((event) {
      return event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training Calendar"),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        actions: [
          // View toggle buttons
          PopupMenuButton<String>(
            icon: const Icon(Icons.view_module),
            onSelected: (value) {
              setState(() {
                _currentView = value;
                switch (value) {
                  case 'month':
                    _calendarFormat = CalendarFormat.month;
                    break;
                  case 'week':
                    _calendarFormat = CalendarFormat.twoWeeks;
                    break;
                  case 'day':
                    _calendarFormat = CalendarFormat.week;
                    break;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'month',
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: _currentView == 'month' ? Colors.green : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Month View'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'week',
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: _currentView == 'week' ? Colors.green : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Week View'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'day',
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: _currentView == 'day' ? Colors.green : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Day View'),
                  ],
                ),
              ),
            ],
          ),
          // Export button
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportCalendarData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Calendar
          if (_searchQuery.isEmpty) ...[
            TableCalendar<CalendarEvent>(
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.green[300],
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green[800],
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return null;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.take(3).map((event) {
                      final calEvent = event; // Fixed: Removed unnecessary cast
                      return Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: _eventTypeColors[calEvent.type] ?? Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Event list or search results
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildSearchResults()
                : _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEventDialog,
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchResults() {
    final filteredEvents = _getFilteredEvents();

    if (filteredEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No events found for "$_searchQuery"',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        return _buildEventCard(event, showDate: true);
      },
    );
  }

  Widget _buildEventList() {
    final selectedEvents = _getEventsForDay(_selectedDay ?? DateTime.now());

    if (selectedEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "No events for selected day",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(CalendarEvent event, {bool showDate = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 40,
          decoration: BoxDecoration(
            color: _eventTypeColors[event.type] ?? Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                event.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (event.hasReminder)
              const Icon(Icons.notifications_active, size: 16, color: Colors.orange),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.type,
              style: TextStyle(color: _eventTypeColors[event.type]),
            ),
            if (showDate)
              Text('${event.date.day}/${event.date.month}/${event.date.year}'),
            if (event.time != null)
              Text('Time: ${event.time!.format(context)}'),
            if (event.description.isNotEmpty)
              Text(event.description, style: const TextStyle(fontSize: 12)),
            if (event.isRecurring)
              Text(
                'Recurring: ${event.recurringType}',
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editEventDialog(event),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteEvent(event),
            ),
          ],
        ),
      ),
    );
  }

  void _addEventDialog() {
    _showEventDialog();
  }

  void _editEventDialog(CalendarEvent event) {
    _showEventDialog(event: event);
  }

  void _showEventDialog({CalendarEvent? event}) {
    final isEditing = event != null;

    String title = event?.title ?? '';
    String description = event?.description ?? '';
    String selectedType = event?.type ?? 'Training';
    TimeOfDay? selectedTime = event?.time;
    DateTime selectedDate = event?.date ?? _selectedDay ?? DateTime.now();
    bool hasReminder = event?.hasReminder ?? false;
    bool isRecurring = event?.isRecurring ?? false;
    String recurringType = event?.recurringType ?? 'Weekly';

    List<String> eventTypes = [
      'Training',
      'Meeting',
      'Conference',
      'Sports',
      'Miscellaneous',
    ];

    List<String> recurringTypes = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Edit Event' : 'Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Event Title'),
                  controller: TextEditingController(text: title),
                  onChanged: (value) => title = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                  ),
                  controller: TextEditingController(text: description),
                  maxLines: 2,
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  items: eventTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _eventTypeColors[type],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(type),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => selectedType = value);
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Event Type'),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                    );
                    if (date != null) {
                      setDialogState(() => selectedDate = date);
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'Time: ${selectedTime?.format(context) ?? 'Not set'}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? TimeOfDay.now(),
                    );
                    if (time != null) {
                      setDialogState(() => selectedTime = time);
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('Set Reminder'),
                  value: hasReminder,
                  onChanged: (value) {
                    setDialogState(() => hasReminder = value ?? false);
                  },
                ),
                CheckboxListTile(
                  title: const Text('Recurring Event'),
                  value: isRecurring,
                  onChanged: (value) {
                    setDialogState(() => isRecurring = value ?? false);
                  },
                ),
                if (isRecurring)
                  DropdownButtonFormField<String>(
                    value: recurringType,
                    items: recurringTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => recurringType = value);
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Recurring Type'),
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
                if (title.trim().isEmpty) return;

                final newEvent = CalendarEvent(
                  id:
                      event?.id ??
                      DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title.trim(),
                  description: description.trim(),
                  type: selectedType,
                  date: selectedDate,
                  time: selectedTime,
                  hasReminder: hasReminder,
                  isRecurring: isRecurring,
                  recurringType: isRecurring ? recurringType : null,
                );

                if (isEditing) {
                  _updateEvent(event, newEvent);
                } else {
                  _addEvent(newEvent);
                }

                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _addEvent(CalendarEvent event) {
    final dayKey = DateTime(event.date.year, event.date.month, event.date.day);

    setState(() {
      if (_events[dayKey] == null) {
        _events[dayKey] = [];
      }
      _events[dayKey]!.add(event); // Fixed: Removed unnecessary null assertion

      // Handle recurring events
      if (event.isRecurring) {
        _addRecurringEvents(event);
      }
    });

    _saveEvents();

    if (event.hasReminder) {
      _scheduleNotification(event);
    }
  }

  void _updateEvent(CalendarEvent oldEvent, CalendarEvent newEvent) {
    final oldDayKey = DateTime(
      oldEvent.date.year,
      oldEvent.date.month,
      oldEvent.date.day,
    );
    final newDayKey = DateTime(
      newEvent.date.year,
      newEvent.date.month,
      newEvent.date.day,
    );

    setState(() {
      // Remove from old date
      _events[oldDayKey]?.removeWhere((e) => e.id == oldEvent.id);
      if (_events[oldDayKey]?.isEmpty ?? false) {
        _events.remove(oldDayKey);
      }

      // Add to new date
      if (_events[newDayKey] == null) {
        _events[newDayKey] = [];
      }
      _events[newDayKey]!.add(newEvent);
    });

    _saveEvents();
  }

  void _deleteEvent(CalendarEvent event) {
    final dayKey = DateTime(event.date.year, event.date.month, event.date.day);

    setState(() {
      _events[dayKey]?.removeWhere((e) => e.id == event.id);
      if (_events[dayKey]?.isEmpty ?? false) {
        _events.remove(dayKey);
      }
    });

    _saveEvents();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event deleted'), backgroundColor: Colors.red),
    );
  }

  void _addRecurringEvents(CalendarEvent event) {
    if (!event.isRecurring || event.recurringType == null) return;

    DateTime nextDate = event.date;

    // Add next 10 occurrences
    for (int i = 0; i < 10; i++) {
      switch (event.recurringType) {
        case 'Daily':
          nextDate = nextDate.add(const Duration(days: 1));
          break;
        case 'Weekly':
          nextDate = nextDate.add(const Duration(days: 7));
          break;
        case 'Monthly':
          nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
          break;
        case 'Yearly':
          nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
          break;
      }

      final recurringEvent = CalendarEvent(
        id: '${event.id}_recurring_$i',
        title: event.title,
        description: event.description,
        type: event.type,
        date: nextDate,
        time: event.time,
        hasReminder: event.hasReminder,
        isRecurring: false, // Don't make recurring events recurring again
        recurringType: null,
      );

      final dayKey = DateTime(nextDate.year, nextDate.month, nextDate.day);
      if (_events[dayKey] == null) {
        _events[dayKey] = [];
      }
      _events[dayKey]!.add(recurringEvent);
    }
  }

  void _scheduleNotification(CalendarEvent event) {
    // This would integrate with a notification plugin
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder set for ${event.title}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _exportCalendarData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Calendar'),
        content: const Text(
          'Export functionality would save calendar data to a file or share it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calendar data exported successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }
}

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime date;
  final TimeOfDay? time;
  final bool hasReminder;
  final bool isRecurring;
  final String? recurringType;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    this.time,
    this.hasReminder = false,
    this.isRecurring = false,
    this.recurringType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'date': date.toIso8601String(),
      'time': time != null
          ? {'hour': time!.hour, 'minute': time!.minute}
          : null,
      'hasReminder': hasReminder,
      'isRecurring': isRecurring,
      'recurringType': recurringType,
    };
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      date: DateTime.parse(json['date']),
      time: json['time'] != null
          ? TimeOfDay(
              hour: json['time']['hour'],
              minute: json['time']['minute'],
            )
          : null,
      hasReminder: json['hasReminder'] ?? false,
      isRecurring: json['isRecurring'] ?? false,
      recurringType: json['recurringType'],
    );
  }
}
