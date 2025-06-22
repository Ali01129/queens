import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentPos;
  Location _locationController = Location();
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  void getLocationUpdates() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        final updatedPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        setState(() {
          _currentPos = updatedPosition;
        });

        // Move camera to new location
        if (_mapController != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPos!));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPos == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPos!,
          zoom: 15,
        ),
        onMapCreated: (controller) => _mapController = controller,
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            position: _currentPos!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          )
        },
      ),
    );
  }
}