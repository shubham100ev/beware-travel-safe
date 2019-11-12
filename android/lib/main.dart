import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  Position position;
  Widget _child;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  // final LatLng _center = const LatLng(28.644800, 77.216721);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Beware Travel Safe'),
          backgroundColor: Colors.green[700],
        ),
        body: _child,
        // GoogleMap(
        //   mapType: MapType.normal,
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(
        //     target: _center,
        //     zoom: 11.0,
        //   ),
        // ),
      ),
    );
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("current location"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "current location"),
      ),
    ].toSet();
  }
}
