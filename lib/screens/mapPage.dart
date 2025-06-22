import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const LatLng map = LatLng(37.4223, -122.0848);
  static const LatLng map2 = LatLng(37.3346, -122.0090);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: map, zoom: 13),
        markers: {
          Marker(markerId: MarkerId("_currentLocation"),icon: BitmapDescriptor.defaultMarker, position: map),
          Marker(markerId: MarkerId("_sourceLocation"),icon: BitmapDescriptor.defaultMarker, position: map2)
        },
      ),
    );
  }
}
