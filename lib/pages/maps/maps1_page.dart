import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps1Page extends StatefulWidget {
  @override
  State<Maps1Page> createState() => _Maps1PageState();
}

class _Maps1PageState extends State<Maps1Page> {
  Position? currentPos;
  Marker? myPosMarker;
  BitmapDescriptor? customMarker;

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("MARC1"),
      position: LatLng(-12.025770870405688, -76.98708066190207),
    ),
  };

  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      "assets/markers/orange.png",
    );

    markers.add(
      Marker(
        markerId: MarkerId(markers.length.toString()),
        position: LatLng(currentPos!.latitude, currentPos!.longitude),
        icon: customMarker!,
        infoWindow: InfoWindow(
          title: "Mi posición actual",
          snippet: "Ubicación en tiempo real",
        ),
      ),
    );
  }

  Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Servicio geolocalizacion inhabilitado");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permisos denegados");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permiso denegado para siemopre");
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      currentPos = position;
      // myPosMarker = Marker(
      //   markerId: MarkerId("Mypos"),
      //   position: LatLng(currentPos!.latitude, currentPos!.longitude),
      // );
      // markers.add(myPosMarker!);

      setCustomMarker();
      setState(() {});
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currentPos == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onTap: (argument) {
                Marker newMarker = Marker(
                  markerId: MarkerId(markers.length.toString()),
                  position: argument,
                );
                markers.add(newMarker);
                setState(() {});
              },
              markers: markers,
              // markers: {myPosMarker!},
              initialCameraPosition: CameraPosition(
                target: LatLng(currentPos!.latitude, currentPos!.longitude),
                zoom: 17,
              ),
            ),
    );
  }
}
