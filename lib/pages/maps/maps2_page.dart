import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebaseconn2g16/utils/home_controller.dart';
import 'package:firebaseconn2g16/utils/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps2Page extends StatefulWidget {
  const Maps2Page({super.key});

  @override
  State<Maps2Page> createState() => _Maps2PageState();
}

class _Maps2PageState extends State<Maps2Page> {
  Set<Marker> markers = {};

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final _mapController = HomeController();

  Future<void> loadPlaces() async {
    Set<Marker> auxMarkers = {};
    BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      "assets/markers/green.png",
    );

    places.forEach((lugar) {
      auxMarkers.add(
        Marker(
          markerId: MarkerId(lugar.id.toString()),
          position: lugar.position,
          icon: customMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      child: Image.network(
                        lugar.urlImage,
                        width: 250,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            lugar.name,
                            style: TextStyle(fontSize: 16, fontWeight: .bold),
                          ),
                          SizedBox(height: 4),
                          Text(lugar.services, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              lugar.position,
            );
          },
        ),
      );
    });
    print("--------------------------");
    print(markers);
    markers = auxMarkers;
    setState(() {});
  }

  @override
  void initState() {
    loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maps2 ")),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) async {
              _mapController.onMapCreated(controller);
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.05602263091387, -76.93596240179183),
              zoom: 17,
            ),

            onTap: (argument) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: markers,
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 250,
            offset: 60,
          ),
        ],
      ),
    );
  }
}
