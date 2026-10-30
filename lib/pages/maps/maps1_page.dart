import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps1Page extends StatelessWidget {
  const Maps1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-11.840639242780666, -77.15393297675759),
          zoom: 15,
        ),
      ),
    );
  }
}
