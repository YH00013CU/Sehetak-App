import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyLocatorScreen extends StatefulWidget {
  @override
  _EmergencyLocatorScreenState createState() => _EmergencyLocatorScreenState();
}

class _EmergencyLocatorScreenState extends State<EmergencyLocatorScreen> {
  bool? _serviceEnabled;
  loc.LocationData? _locationData;
  final loc.Location location = loc.Location();
  List<dynamic>? _nearbyHospitals;

  Future<void> _getCurrentLocation() async {
    await _requestPermission();
    _locationData = await location.getLocation();
    _getNearbyHospitals(_locationData!.latitude, _locationData!.longitude);
  }

  @override
  void initState() {
    super.initState();
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    await location.requestPermission();
    await location.requestService();
    if (status.isGranted) {
      //print('done');
    } else if (status.isDenied) {
      // Show a message to the user that permission is needed.
      print('Location permission is denied.');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      //print('Permanently Denied');
    }
  }

  Future<void> _getNearbyHospitals(double? latitude, double? longitude) async {
    final String apiKey = 'AIzaSyAHUSiBgnGc4WBgy0H7SxUtpu8jShcBXgE';
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    final String type = 'hospital';
    final String radius = '5000'; // Search within 5km radius
    final String country = 'eg'; // Egypt country code

    final String url =
        '$baseUrl?location=$latitude,$longitude&radius=$radius&type=$type&key=$apiKey&country=$country';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    setState(() {
      _nearbyHospitals = data['results'];
    });
  }

  Widget _buildHospitalCard(dynamic hospital) {
    return Card(
      color: Colors.blueGrey[100],
      child: ListTile(
        leading: Icon(Icons.local_hospital, color: Colors.red),
        title: Text(hospital['name']),
        subtitle: Text(hospital['vicinity']),
        onTap: () {
          _openMaps(hospital['geometry']['location']['lat'], hospital['geometry']['location']['lng']);
        },
      ),
    );
  }

  Future<void> _openMaps(double lat, double lng) async {
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Locator'),
      ),
      body: _nearbyHospitals != null
          ? ListView.builder(
              itemCount: _nearbyHospitals!.length,
              itemBuilder: (context, index) {
                return _buildHospitalCard(_nearbyHospitals![index]);
              },
            )
          : Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _getCurrentLocation();
                },
                icon: Icon(Icons.local_hospital, color: Colors.white),
                label: Text(
                  'Find Nearby Hospitals',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Emergency Locator App',
    home: EmergencyLocatorScreen(),
  ));
}
