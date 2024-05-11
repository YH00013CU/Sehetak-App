import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearby Hospitals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = "AIzaSyBDLNynlu9GO2Dhal_XW4EnJSvr7gnNNfU"; // Replace with your actual API key
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchNearbyHospitals());
  }

  void fetchNearbyHospitals() async {
    const double latitude = 30.044420; // Example: Latitude for Cairo, Egypt
    const double longitude = 31.235712; // Example: Longitude for Cairo, Egypt
    const String radius = "10000"; // Search within 10000 meters
    const String type = "hospital"; // Search for hospitals

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$type&key=$apiKey');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['results'] != null) {
        setState(() {
          markers.clear();
          jsonResponse['results'].forEach((hospital) {
            LatLng hospitalLocation = LatLng(hospital['geometry']['location']['lat'], hospital['geometry']['location']['lng']);
            markers.add(Marker(
              markerId: MarkerId(hospital['place_id']),
              position: hospitalLocation,
              infoWindow: InfoWindow(
                title: hospital['name'],
                snippet: hospital['vicinity'],
              ),
            ));
          });
        });
      }
    } else {
      print('Failed to fetch nearby hospitals.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Hospitals"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.044420, 31.235712),
          zoom: 12,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
