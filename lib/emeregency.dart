import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency {
  final String name;
  final String number;

  Emergency({required this.name, required this.number});
}

class EmergencyContactsScreen extends StatelessWidget {
  final List<Emergency> emergencies = [
    Emergency(name: 'Main Ambulance', number: '123'),
    Emergency(name: 'Tourist Police', number: '126'),
    Emergency(name: 'Traffic Police', number: '128'),
    Emergency(name: 'Emergency Police', number: '122'),
    Emergency(name: 'Fire Department', number: '180'),
    Emergency(name: 'Electricity Emergency', number: '121'),
    Emergency(name: 'Natural Gas Emergency', number: '129'),
    Emergency(name: 'Clock', number: '150'),
    Emergency(name: 'International Calls from land lines', number: '144'),
    Emergency(name: 'Land line telephone bills inquiries', number: '177'),
    Emergency(name: 'Land line telephone complaints', number: '16'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        itemCount: emergencies.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Icon(Icons.phone, color: Colors.white, size: 30),
                title: Text(
                  emergencies[index].name,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  emergencies[index].number,
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () async {
                  final url = 'tel:${emergencies[index].number}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch dialer for ${emergencies[index].name}'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
          
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
}
