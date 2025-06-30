import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:queens/components/backButton.dart';
import 'package:queens/components/bottomSheet.dart';
import 'package:queens/components/button.dart';
import 'package:queens/components/colors/appColor.dart';

import '../components/addressPage/addressBottomSheet.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  LatLng? _currentPos;
  final Location _locationController = Location();
  GoogleMapController? _mapController;

  final TextEditingController locationController = TextEditingController();

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

  void _goToCurrentLocation() {
    if (_mapController != null && _currentPos != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPos!));
    }
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      body: _currentPos == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPos!,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                position: _currentPos!,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              )
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // We'll use custom button
          ),
          // Back Button (top-left)
          Positioned(
            top: 50,
            left: 10,
            child: BackButtonWidget(darkMode: false)
          ),
          // Location Button (bottom-center)
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - 100, // Assuming button width = 150
            child: SizedBox(
              width: 200, // Optional: fix width for centering
              child: Button(
                title: "Add to Location",
                textColor: AppColors.lightbg,
                bg: AppColors.buttonPrimary,
                onTapCallback: () {
                  showAddLocationBottomSheet(
                    context,
                    darkMode: darkMode,
                    controller: locationController,
                    onAdd: () {
                      final locationName = locationController.text;
                      print("Location added: $locationName");
                      print('Current location: ${_currentPos!.latitude}, ${_currentPos!.longitude}');

                      locationController.clear();
                    },
                  );
                  // Your callback logic
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}