import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/google_map_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _userLocationController = TextEditingController();
  Position? currentPos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF29B2DD),
        elevation: 0.0,
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF29B2DD), Color(0xFF33AADD), Color(0xFF2DC8EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.47, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: _userLocationController,
                onChanged: (value) {},
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search location',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  // 1. Check GPS is enabled.
                  if (await _isGpsEnabled()) {
                    // 2. Check App permission
                    if (await _isLocationPermissionProvided()) {
                      _getCurrentDeviceLocation();
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      child: Icon(Icons.my_location, color: Colors.white),
                    ),

                    title: Text(
                      "Current Location",
                      // style: TextStyles.semiboldWhite20,
                    ),
                    subtitle: Text(
                      "Using GPS",
                      // style: TextStyles.regularWhite16.copyWith(
                      //   color: Colors.black45,
                      // ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Lat : ${currentPos?.latitude ?? ''}",
                    // style: TextStyles.regularWhite20,
                  ),
                  Text(
                    "Long: ${currentPos?.longitude ?? ''}",
                    // style: TextStyles.regularWhite20,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () async {
                  if (currentPos != null) {
                    LatLng? latLng = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => GoogleMapPage(position: currentPos!),
                      ),
                    );

                    Navigator.pop(context, latLng);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      child: Icon(Icons.map_rounded, color: Colors.white),
                    ),
                    title: Text(
                      "Map Location",
                      // style: TextStyles.semiboldWhite20,
                    ),
                    subtitle: Text(
                      "Using Google Map",
                      // style: TextStyles.regularWhite16.copyWith(
                      //   color: Colors.black45,
                      // ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPos != null) {
                      Navigator.pop(context, currentPos);
                    } else if (_userLocationController.text.isNotEmpty) {
                      Navigator.pop(context, _userLocationController.text);
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// GET DEVICE CURRENT LOCATION USING GPS
  Future<void> _getCurrentDeviceLocation() async {
    try {
      Position currentPos = await Geolocator.getCurrentPosition();

      print("Lat : ${currentPos.latitude}");
      print("Long : ${currentPos.longitude}");
      print("speed : ${currentPos.speed}");

      setState(() {
        this.currentPos = currentPos;
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future<bool> _isGpsEnabled() async {
    bool isGpsEnabled = false;

    isGpsEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isGpsEnabled) {
      // show error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "GPS service are disabled. Please enable the GPS service",
          ),
        ),
      );
    }
    return isGpsEnabled;
  }

  Future<bool> _isLocationPermissionProvided() async {
    late LocationPermission permission;

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission permanently denied...")),
      );
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied by user...")),
        );
        return false;
      }
    }

    return true;
  }
}
