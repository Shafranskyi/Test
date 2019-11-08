import 'package:flutter/material.dart';
import 'package:test_project/first/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

class GoogleMapsPage extends StatefulWidget {
  GoogleMapsPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(50.44636639, 30.52551272);
  Set<Marker> markers = Set();
  MapType _currentMapType = MapType.normal;
  LatLng centerPosition;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
      print("dddd" + _currentMapType.toString());
    });
  }

  void _onAddMarkerButtonPressed() {
    InfoWindow infoWindow =
    InfoWindow(title: "Location" + markers.length.toString());
    Marker marker = Marker(
      markerId: MarkerId(markers.length.toString()),
      infoWindow: infoWindow,
      position: centerPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Google map',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              myLocationEnabled: true,
              markers: markers,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: new FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  child: new Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: new FloatingActionButton(
                  onPressed: _onAddMarkerButtonPressed,
                  child: new Icon(
                    Icons.edit_location,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    centerPosition = position.target;
  }
}