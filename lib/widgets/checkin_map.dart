import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';

class CheckinMap extends StatefulWidget {
  const CheckinMap({
    Key? key,
    required this.address
  }) : super(key: key);

  final String address;

  @override
  _CheckinMapState createState() => _CheckinMapState();
}

class _CheckinMapState extends State<CheckinMap> {
  late EmployeeViewModel viewModel;
  late GoogleMapController controller;
  var cameraTarget = const LatLng(37.42796133580664, -122.085749655962);
  late CameraPosition _kGooglePlex;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    viewModel = EmployeeViewModel();

    _kGooglePlex = CameraPosition(
      target: cameraTarget,
      zoom: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            controller = controller;
          });
          addMarker();
        },
        markers: Set<Marker>.of(markers.values)
    );
  }

  void addMarker() async{
    List<Location> loc = await viewModel.getLocations(widget.address);
    const MarkerId markerId = MarkerId("checkInLocation");
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        loc[0].latitude,
        loc[0].longitude
      ),
      infoWindow: InfoWindow(title: widget.address, snippet: '*'),
    );

    setState(() {
      markers[markerId] = marker;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(
            loc[0].latitude,
            loc[0].longitude
        ))
      ));
      cameraTarget = LatLng(
          loc[0].latitude,
          loc[0].longitude
      );
    });
  }
}
