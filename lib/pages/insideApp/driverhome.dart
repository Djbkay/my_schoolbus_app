import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_map/pages/constants/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Function to get the current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permission is granted, return the current position
    return await Geolocator.getCurrentPosition();
  }

  // Function to start tracking the driver's location
  void _startTracking(BuildContext context, int routeIndex) async {
    try {
      Position position = await _determinePosition();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tracking started for Route $routeIndex. '
            'Current Location: Lat: ${position.latitude}, Long: ${position.longitude}'),
      ));
      // You can add code here to continue tracking or send the location to a server.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen sizing logic similar to the previous one
    final Size deviceSize = MediaQuery.of(context).size;
    final double widthScreen = deviceSize.width;
    final double heightScreen = deviceSize.height;
    final isMobile = widthScreen < 600;
    final isMobileRotate = heightScreen < 600;
    final isRotate = isMobileRotate && widthScreen > heightScreen;
    final appBarHeight = isRotate ? widthScreen / 10 : heightScreen / 10;
    final screenPaddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight - screenPaddingTop),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Driver Screen',
            style: TextStyle(
              color: myMainColor,
              fontSize: 40.0,
              fontWeight: FontWeight.w400,
              letterSpacing: isMobile ? 0 : 0.5,
            ),
          ),
          backgroundColor: transparentColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: myMainColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        height: heightScreen - appBarHeight,
        padding: const EdgeInsets.all(14.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double availableHeight = constraints.maxHeight;
            double availableWidth = constraints.maxWidth;
            int crossAxisCount = 2;
            int rowCount = (10 / crossAxisCount).ceil();
            double itemHeight = (availableHeight - (rowCount - 1) * 14.0) / rowCount;
            double itemWidth = (availableWidth - (crossAxisCount - 1) * 14.0) / crossAxisCount;

            return GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14.0,
              mainAxisSpacing: 14.0,
              childAspectRatio: itemWidth / itemHeight,
              children: List.generate(10, (index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromRGBO(121, 9, 31, 1), backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    _startTracking(context, index + 1);
                  },
                  child: Text(
                    index == 0
                        ? 'Start Driving Lefkoşa 1'
                        : index == 1
                        ? 'Start Driving Lefkoşa 2'
                        : index == 2
                        ? 'Start Driving Kızılbaş'
                        : index == 3
                        ? 'Start Driving Gönyeli 1'
                        : index == 4
                        ? 'Start Driving Gönyeli 2'
                        : index == 5
                        ? 'Start Driving Gönyeli / Metehan'
                        : index == 6
                        ? 'Start Driving Ortaköy / Yenikent'
                        : index == 7
                        ? 'Start Driving Campus - Kyrenia'
                        : index == 8
                        ? 'Start Driving Campus - Güzelyurt'
                        : 'Start Driving Campus - Famagusta',
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
