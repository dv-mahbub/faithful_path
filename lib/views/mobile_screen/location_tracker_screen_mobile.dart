import 'package:faithful_path/views/mobile_screen/salat_time_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationTrackerScreenMobile extends StatefulWidget {
  const LocationTrackerScreenMobile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LocationTrackerScreenMobileState createState() =>
      _LocationTrackerScreenMobileState();
}

class _LocationTrackerScreenMobileState extends State<LocationTrackerScreenMobile> {
  LatLng currentLocation = LatLng(20.9435, 90.2748);
  double zoom = 4;
  Key mapKey = UniqueKey(); // Add this line


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: .01.sh,),
              //for showing map
              SizedBox(
                height: .78.sh,
                width: .9.sw,
                child: Stack(
                  children: [
                    FlutterMap(
                      key: mapKey,
                      options: MapOptions(
                        center: currentLocation,
                        zoom: zoom,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 16.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        onPressed: locate,
                        child: const Icon(Icons.my_location),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: .03.sh,),
              ElevatedButton(
                child: const Text('Use current location'),
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> SalatTimeScreenMobile(currentLocation: currentLocation))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> locate() async {
    Position a = await determinePosition();
    setState(() {
      zoom = 14;
      currentLocation = LatLng(a.latitude, a.longitude);
      mapKey = UniqueKey();
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}
