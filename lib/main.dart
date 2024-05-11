import 'package:flutter/material.dart';
import 'FirstAidTutorials.dart';
import 'EmergencyLocator.dart';
import 'MedicationReminder.dart';
import 'emeregency.dart'; // Import the MedicationReminder.dart file
import 'game.dart'; // Import the game.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Aid App',
      theme: ThemeData(
        primaryColor: Color(0xFF1565C0), // Custom primary color
        hintColor: Color(0xFFFFC107), // Custom accent color
        scaffoldBackgroundColor: Colors.grey[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/firstAid': (context) => FirstAidScreen(),
        '/emergencyLocator': (context) => EmergencyLocatorScreen(),
        '/emergency': (context) => EmergencyContactsScreen(),
        '/medicationReminder': (context) => MedicationReminderScreen(),
        '/game': (context) => GameScreen(), // Add the route to the game.dart file
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/logo/Green_and_Blue_Square_Medical_Logo-removebg-preview.png',
                width: 100, // Adjust the width as needed
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/firstAid');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blueAccent, // Changed to blue for a medical card look
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medical_services, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'First Aid Tutorials',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/emergencyLocator');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.green, // Changed to green for a medical card look
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Emergency Locator',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/emergency');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.redAccent, // Changed to red for a medical card look
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.contacts, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Emergency Contacts',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/medicationReminder');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.orangeAccent, // Changed to orange for a medical card look
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Medication Reminder',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/game'); // Navigate to the game.dart file
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.purpleAccent, // Changed to purple for a game card look
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.games, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Interactive Scenarios Game',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
}
