import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationReminderScreen extends StatefulWidget {
  @override
  _MedicationReminderScreenState createState() =>
      _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  String medicineName = '';
  TimeOfDay? selectedTime;
  String? selectedMedicineType;
  List<String> medicineTypes = ['Syringe', 'Bottle', 'Pill'];
  List<Map<String, String>> remindersList = []; // List to hold reminders

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final reminders = prefs.getStringList('reminders') ?? [];
    setState(() {
      remindersList = reminders
          .map((reminder) => Map<String, String>.from(json.decode(reminder)))
          .toList();
    });
  }

  Future<void> _saveReminder() async {
    if (medicineName.isNotEmpty &&
        selectedMedicineType != null &&
        selectedTime != null) {
      // Add reminder to the list
      remindersList.add({
        'medicine': medicineName,
        'type': selectedMedicineType!,
        'time': selectedTime!.format(context),
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'reminders',
          remindersList
              .map((reminder) => json.encode(reminder))
              .toList());

      // Clear input fields after saving
      setState(() {
        medicineName = '';
        selectedMedicineType = null;
        selectedTime = null;
      });
    }
  }

  void _deleteReminder(int index) async {
    setState(() {
      remindersList.removeAt(index);
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'reminders',
        remindersList
            .map((reminder) => json.encode(reminder))
            .toList());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  medicineName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Medicine Name',
                hintText: 'Enter the name of your medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMedicineTypeIcon('Syringe', Icons.local_hospital),
                _buildMedicineTypeIcon('Bottle', Icons.medication_liquid),
                _buildMedicineTypeIcon('Pill', Icons.local_pharmacy),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(selectedTime != null
                    ? 'Selected Time: ${selectedTime!.format(context)}'
                    : 'Select Time'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveReminder,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text('Save Reminder'),
              ),
            ),
            const SizedBox(height: 16.0),
            // Display the list of saved reminders
            Expanded(
              child: ListView.builder(
                itemCount: remindersList.length,
                itemBuilder: (BuildContext context, int index) {
                  final reminder = remindersList[index];
                  return Card(
                    elevation: 4,
                    margin:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: _buildMedicineIcon(reminder['type']!),
                      title: Text('Medicine: ${reminder['medicine']}'),
                      subtitle: Text('Time: ${reminder['time']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteReminder(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF1565C0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Emergency',
            backgroundColor: Color(0xFFFFC107),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Emergency Contacts',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Medication Reminder',
            backgroundColor: Colors.orangeAccent,
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/emergencyLocator');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/emergency');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/medicationReminder');
          }
        },
      ),
    );
  }

  Widget _buildMedicineTypeIcon(String type, IconData iconData) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedMedicineType = type;
            });
          },
          child: Icon(iconData,
              size: 50.0,
              color: selectedMedicineType == type ? Colors.blue : Colors.grey),
        ),
        SizedBox(height: 8.0),
        Text(
          type,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineIcon(String type) {
    IconData iconData;
    switch (type) {
      case 'Syringe':
        iconData = Icons.local_hospital;
        break;
      case 'Bottle':
        iconData = Icons.medication_liquid;
        break;
      case 'Pill':
        iconData = Icons.local_pharmacy;
        break;
      default:
        iconData = Icons.local_hospital;
    }

    return Icon(iconData, size: 36, color: Colors.blue);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(home: MedicationReminderScreen()));
}
