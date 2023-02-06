import 'dart:async';
import 'package:tubescozy/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tubescozy/modules/home/home.dart';

class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition initialPosition = CameraPosition(target: LatLng(-7.319805107510004, 112.7396524971812), zoom: 12.0);

  static const CameraPosition targetPosition = CameraPosition(target: LatLng(-7.304843094690288, 112.7345426478516), zoom: 18.0,  tilt: 60);
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
          markerId: MarkerId('1'),
          position: LatLng(-7.304843094690288, 112.7345426478516),
          infoWindow: InfoWindow(
            title: 'Gerai Cozy Royal Plaza Surabaya'
          )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(-7.311994478856962, 112.73454282018993),
        infoWindow: InfoWindow(
            title: 'Gerai Cozy Maspion Square Surabaya'
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(-7.3135264918468375, 112.74844806129957),
        infoWindow: InfoWindow(
            title: 'Gerai Cozy Plaza Marina Surabaya'
        )
    ),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(-7.342536248829212, 112.72677488538704),
        infoWindow: InfoWindow(
            title: 'Gerai Cozy City of Tomorrow Surabaya'
        )
    ),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(-7.273910654186293, 112.78050408804212),
        infoWindow: InfoWindow(
            title: 'Gerai Cozy Galaxy Mall 3 Surabaya'
        )
    ),
    Marker(
        markerId: MarkerId('6'),
        position: LatLng(-7.260744295623915, 112.73896848355137),
        infoWindow: InfoWindow(
            title: 'Gerai Cozy Tunjungan Plaza Surabaya'
        )
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),
    ),

        color: Colors.white,

        ),//
        title: const Text("Gerai Cozy Terdekat"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: Set<Marker>.of(_marker),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(

        onPressed: () {
          CariCozy();
        },
        label: const Text("Cari Cozy Terdekat Yuk!"),
        icon: const Icon(Icons.directions),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> CariCozy() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}