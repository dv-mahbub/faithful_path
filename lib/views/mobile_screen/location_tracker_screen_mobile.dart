import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class LocationTrackerScreenMobile extends StatefulWidget {
  const LocationTrackerScreenMobile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LocationTrackerScreenMobileState createState() =>
      _LocationTrackerScreenMobileState();
}

class _LocationTrackerScreenMobileState extends State<LocationTrackerScreenMobile> {
  double latitude = 20.9435;
  double longitude = 90.2748;
  double zoom = 4;

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
                      options: MapOptions(
                        center: LatLng(latitude, longitude),
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
            ],
          ),
        ),
      ),
    );
  }

  void locate() {

  }
}
