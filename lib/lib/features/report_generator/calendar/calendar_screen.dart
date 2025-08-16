import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart'; // Calendar widget
import 'package:intl/intl.dart'; // For date formatting

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to store events, where key is date and value is a list of events for that date
  final Map<DateTime, List<Event>> _events = {
    // Example events
    DateTime.utc(2025, 7, 15): [const Event('Team Meeting'), const Event('Project Deadline')],
    DateTime.utc(2025, 7, 17): [const Event('Training Session')],
  };

  // Controllers for adding new events
  final TextEditingController _eventTitleController = TextEditingController();
  DateTime _selectedEventDate = DateTime.now();

  @override
  void dispose() {
    _eventTitleController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Return events for the given day, ignoring time part
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; // update `_focusedDay` here as well
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEventDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEventDate) {
      setState(() {
        _selectedEventDate = picked;
      });
    }
  }

  void _addEvent() {
    if (_eventTitleController.text.isEmpty) {
      // Show a simple message box instead of alert()
      _showMessageBox(context, 'Error', 'Event title cannot be empty.');
      return;
    }

    final newEvent = Event(_eventTitleController.text);
    final eventDate = DateTime.utc(_selectedEventDate.year, _selectedEventDate.month, _selectedEventDate.day);

    setState(() {
      if (_events[eventDate] != null) {
        _events[eventDate]!.add(newEvent);
      } else {
        _events[eventDate] = [newEvent];
      }
    });

    _eventTitleController.clear();
    _showMessageBox(context, 'Success', 'Event added successfully!');
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
        title: const Text('Events Calendar'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red[300], // Event marker color
                    shape: BoxShape.circle,
                  ),
                  markersAutoAligned: true,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, // Hide format button
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.green[700]),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.green[700]),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Events for Selected Day:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Display events for the selected day
            ..._getEventsForDay(_selectedDay ?? _focusedDay).map((event) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.event, color: Colors.green[700]),
                    title: Text(event.title),
                    subtitle: Text(DateFormat('yyyy-MM-dd').format(_selectedDay ?? _focusedDay)),
                  ),
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Upcoming Event:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _eventTitleController,
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Date: ${DateFormat('yyyy-MM-dd').format(_selectedEventDate)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: Colors.green),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Add Event',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

