/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  //const MapSceen({super.key});
  final int routeIndex; // Route number

  const MapScreen({super.key, required this.routeIndex});

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  late GoogleMapController mapController;

  // Define waypoints for different routes
  final Map<String, List<LatLng>> waypointsData = {
    "1": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2106, 33.3436),
      LatLng(35.2110, 33.3707),
      LatLng(35.2113, 33.3758),
      LatLng(35.2093, 33.3667),
      LatLng(35.2021, 33.3674),
      LatLng(35.1990, 33.3678),
      LatLng(35.1948, 33.3678),
      LatLng(35.2263, 33.3261),
      LatLng(35.1880, 33.3661),
      LatLng(35.2297, 33.3246),
    ],
    "2": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.1867, 33.3655),
      LatLng(35.1823, 33.3624),
      LatLng(35.1859, 33.3573),
      LatLng(35.1907, 33.3519),
      LatLng(35.1941, 33.3482),
      LatLng(35.1998, 33.3407),
      LatLng(35.2051, 33.3302),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "3": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2031, 33.3513),
      LatLng(35.1993, 33.3568),
      LatLng(35.2025, 33.3639),
      LatLng(35.2034, 33.3688),
      LatLng(35.2032, 33.3732),
      LatLng(35.2030, 33.3768),
      LatLng(35.2087, 33.3787),
      LatLng(35.2157, 33.3782),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "4": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2094, 33.2983),
      LatLng(35.2087, 33.3074),
      LatLng(35.2118, 33.3072),
      LatLng(35.2147, 33.3080),
      LatLng(35.2124, 33.3108),
      LatLng(35.2103, 33.3147),
      LatLng(35.2093, 33.3184),
      LatLng(35.2127, 33.3342),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "5": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2100, 33.3149),
      LatLng(35.2123, 33.3108),
      LatLng(35.2182, 33.3034),
      LatLng(35.2217, 33.3009),
      LatLng(35.2256, 33.2984),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "6": [
      LatLng(35.2297, 33.3243),
      LatLng(35.2261, 33.3255),
      LatLng(35.2086, 33.3185),
      LatLng(35.2080, 33.3135),
      LatLng(35.2083, 33.3074),
      LatLng(35.2101, 33.2934),
      LatLng(35.1981, 33.3117),
      LatLng(35.1938, 33.3211),
      LatLng(35.1914, 33.3256),
      LatLng(35.2018, 33.3223),
      LatLng(35.2050, 33.3173),
      LatLng(35.2088, 33.3182),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "7": [
      LatLng(35.2297, 33.3244),
      LatLng(35.2259, 33.3257),
      LatLng(35.2077, 33.3399),
      LatLng(35.2009, 33.3412),
      LatLng(35.1986, 33.3338),
      LatLng(35.1969, 33.3311),
      LatLng(35.1991, 33.3272),
      LatLng(35.2011, 33.3236),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "8": [
      LatLng(35.3326, 33.3144),
      LatLng(35.3304, 33.3257),
      LatLng(35.3338, 33.3325),
      LatLng(35.3342, 33.3404),
      LatLng(35.3338, 33.3316),
      LatLng(35.3300, 33.3274),
      LatLng(35.2858, 33.2796),
      LatLng(35.2297, 33.3246),
    ],
    "9": [
      LatLng(35.1929, 32.9947),
      LatLng(35.2297, 33.3246) ,
    ],
    "10": [
      LatLng(35.1204, 33.9376),
      LatLng(35.2297, 33.3246),
    ]
  };

  // Method to get the Polyline for the selected route
  List<Polyline> _getRoutePolyline() {
    final routeWaypoints = waypointsData[widget.routeIndex.toString()];
    if (routeWaypoints == null) {
      return [];
    }
    return [
      Polyline(
        polylineId: PolylineId('route_${widget.routeIndex}'),
        points: routeWaypoints,
        color: Colors.blue,
        width: 4,
      ),
    ];
  }

  // Method to get the markers for the selected route
  Set<Marker> _getMarkers() {
    final routeWaypoints = waypointsData[widget.routeIndex.toString()];
    if (routeWaypoints == null || routeWaypoints.isEmpty) {
      return {};
    }

    // Markers for start, intermediate (bus stops), and end points
    Set<Marker> markers = {};

    // Start point marker
    markers.add(
      Marker(
        markerId: MarkerId('start_point'),
        position: routeWaypoints[0],
        infoWindow: InfoWindow(title: 'Start Point'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // Intermediate waypoints (bus stops) markers
    for (int i = 1; i < routeWaypoints.length - 1; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('stop_$i'),
          position: routeWaypoints[i],
          infoWindow: InfoWindow(title: 'Bus Stop ${i + 1}'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ),
      );
    }

    // End point marker
    markers.add(
      Marker(
        markerId: MarkerId('end_point'),
        position: routeWaypoints.last,
        infoWindow: InfoWindow(title: 'End Point'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route ${widget.routeIndex} Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: waypointsData[widget.routeIndex.toString()]![0], // Center map on the first point
          zoom: 13.0,
        ),
        polylines: Set<Polyline>.of(_getRoutePolyline()),
        markers: _getMarkers(),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  final int routeIndex; // Route number

  const MapScreen({super.key, required this.routeIndex});

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  String googleAPIKey = 'AIzaSyDBsq1dGSWOL_xKaI1iZaaznJbpkEUs82I'; // Replace with your API key

  // Define waypoints for different routes
  final Map<String, List<LatLng>> waypointsData = {
    "1": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2106, 33.3436),
      LatLng(35.2110, 33.3707),
      LatLng(35.2113, 33.3758),
      LatLng(35.2093, 33.3667),
      LatLng(35.2021, 33.3674),
      LatLng(35.1990, 33.3678),
      LatLng(35.1948, 33.3678),
      LatLng(35.2263, 33.3261),
      LatLng(35.1880, 33.3661),
      LatLng(35.2297, 33.3246),
    ],
    "2": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.1867, 33.3655),
      LatLng(35.1823, 33.3624),
      LatLng(35.1859, 33.3573),
      LatLng(35.1907, 33.3519),
      LatLng(35.1941, 33.3482),
      LatLng(35.1998, 33.3407),
      LatLng(35.2051, 33.3302),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "3": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2031, 33.3513),
      LatLng(35.1993, 33.3568),
      LatLng(35.2025, 33.3639),
      LatLng(35.2034, 33.3688),
      LatLng(35.2032, 33.3732),
      LatLng(35.2030, 33.3768),
      LatLng(35.2087, 33.3787),
      LatLng(35.2157, 33.3782),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "4": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2094, 33.2983),
      LatLng(35.2087, 33.3074),
      LatLng(35.2118, 33.3072),
      LatLng(35.2147, 33.3080),
      LatLng(35.2124, 33.3108),
      LatLng(35.2103, 33.3147),
      LatLng(35.2093, 33.3184),
      LatLng(35.2127, 33.3342),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "5": [
      LatLng(35.2297, 33.3245),
      LatLng(35.2261, 33.3255),
      LatLng(35.2100, 33.3149),
      LatLng(35.2123, 33.3108),
      LatLng(35.2182, 33.3034),
      LatLng(35.2217, 33.3009),
      LatLng(35.2256, 33.2984),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "6": [
      LatLng(35.2297, 33.3243),
      LatLng(35.2261, 33.3255),
      LatLng(35.2086, 33.3185),
      LatLng(35.2080, 33.3135),
      LatLng(35.2083, 33.3074),
      LatLng(35.2101, 33.2934),
      LatLng(35.1981, 33.3117),
      LatLng(35.1938, 33.3211),
      LatLng(35.1914, 33.3256),
      LatLng(35.2018, 33.3223),
      LatLng(35.2050, 33.3173),
      LatLng(35.2088, 33.3182),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "7": [
      LatLng(35.2297, 33.3244),
      LatLng(35.2259, 33.3257),
      LatLng(35.2077, 33.3399),
      LatLng(35.2009, 33.3412),
      LatLng(35.1986, 33.3338),
      LatLng(35.1969, 33.3311),
      LatLng(35.1991, 33.3272),
      LatLng(35.2011, 33.3236),
      LatLng(35.2263, 33.3261),
      LatLng(35.2297, 33.3246),
    ],
    "8": [
      LatLng(35.3326, 33.3144),
      LatLng(35.3304, 33.3257),
      LatLng(35.3338, 33.3325),
      LatLng(35.3342, 33.3404),
      LatLng(35.3338, 33.3316),
      LatLng(35.3300, 33.3274),
      LatLng(35.2858, 33.2796),
      LatLng(35.2297, 33.3246),
    ],
    "9": [
      LatLng(35.1929, 32.9947),
      LatLng(35.2297, 33.3246),
    ],
    "10": [
      LatLng(35.1204, 33.9376),
      LatLng(35.2297, 33.3246),
    ],
  };

  @override
  void initState() {
    super.initState();
    _getPolyline(); // Call the method to fetch the route when the widget is initialized
  }

  // Method to fetch the route and decode polyline from Google Directions API
  Future<void> _getPolyline() async {
    final routeWaypoints = waypointsData[widget.routeIndex.toString()];
    if (routeWaypoints == null || routeWaypoints.length < 2) {
      return;
    }

    LatLng origin = routeWaypoints[0];
    LatLng destination = routeWaypoints.last;
    List<LatLng> waypoints = routeWaypoints.sublist(1, routeWaypoints.length - 1);

    // Convert waypoints to string format for the API request
    String waypointsString = waypoints.map((point) => '${point.latitude},${point.longitude}').join('|');

    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&waypoints=$waypointsString&key=$googleAPIKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var routes = json['routes'];

      if (routes.isNotEmpty) {
        // Get the polyline points
        var points = routes[0]['overview_polyline']['points'];
        polylineCoordinates = _decodePolyline(points);

        setState(() {
          polylines.add(
            Polyline(
              polylineId: PolylineId('route_${widget.routeIndex}'),
              visible: true,
              points: polylineCoordinates,
              color: Colors.blue,
              width: 4,
            ),
          );
        });
      }
    } else {
      print('Failed to fetch the route: ${response.statusCode}');
    }
  }

  // Method to decode the polyline string into LatLng coordinates
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng((lat / 1E5), (lng / 1E5)));
    }
    return polyline;
  }

  // Method to get markers for start and end points
  Set<Marker> _getMarkers() {
    final routeWaypoints = waypointsData[widget.routeIndex.toString()];
    if (routeWaypoints == null || routeWaypoints.isEmpty) {
      return {};
    }

    Set<Marker> markers = {};

    // Start point marker
    markers.add(
      Marker(
        markerId: MarkerId('start_point'),
        position: routeWaypoints[0],
        infoWindow: InfoWindow(title: 'Start Point'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // End point marker
    markers.add(
      Marker(
        markerId: MarkerId('end_point'),
        position: routeWaypoints.last,
        infoWindow: InfoWindow(title: 'End Point'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    // Add markers for each waypoint
    for (int i = 1; i < routeWaypoints.length - 1; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('waypoint_$i'),
          position: routeWaypoints[i],
          infoWindow: InfoWindow(title: 'Waypoint $i'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route ${widget.routeIndex} Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: waypointsData[widget.routeIndex.toString()]![0], // Center map on the first point
          zoom: 13.0,
        ),
        polylines: polylines,
        markers: _getMarkers(),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
