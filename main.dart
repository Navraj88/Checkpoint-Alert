import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the environment variables
  await dotenv.load();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    _initializeMapbox();
  }

  Future<void> _initializeMapbox() async {
    // Fetch the access token from the .env file
    String accessToken = dotenv.env['ACCESS_TOKEN'] ?? "";

    if (accessToken.isEmpty) {
      throw Exception('Mapbox access token is missing.');
    }

    // Pass your access token to MapboxOptions
    MapboxOptions.setAccessToken(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    // Define options for your camera
    CameraOptions camera = CameraOptions(
      center: Point(coordinates: Position(-98.0, 39.5)),
      zoom: 2,
      bearing: 0,
      pitch: 0,
    );

    // Build the map widget with the defined camera options
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Map'),
      ),
      body: MapWidget(
        cameraOptions: camera,
      ),
    );
  }
}
