import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key, required this.position});

  final Position position;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late LatLng latLng;

  @override
  void initState() {
    super.initState();

    latLng = LatLng(widget.position.latitude, widget.position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              buildingsEnabled: true,

              onLongPress: (LatLng selectedLatLng) {
                print(selectedLatLng);

                setState(() {
                  latLng = selectedLatLng;
                });
              },
              markers: {
                Marker(
                  markerId: MarkerId("12345"),
                  position: latLng,
                  infoWindow: InfoWindow(title: "ITPrenure PPP Flutter Batch"),
                ),
              },
              initialCameraPosition: CameraPosition(target: latLng, zoom: 17),
            ),
            Positioned(
              bottom: 20,
              left: 50,
              right: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, latLng);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
