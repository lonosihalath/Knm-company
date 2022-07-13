import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Detail_Sakha extends StatefulWidget {
  final data;
  final double longitude;

  const Detail_Sakha({
    Key? key,
    required this.data,
    required this.longitude,
  }) : super(key: key);

  @override
  State<Detail_Sakha> createState() => _Detail_SakhaState();
}

class _Detail_SakhaState extends State<Detail_Sakha> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex1 = CameraPosition(
    target: LatLng(17.9219072, 102.7682240),
    zoom: 16,
  );
  CameraPosition _kGooglePlex2 = CameraPosition(
    target: LatLng(18.0547392, 102.6795520),
    zoom: 16,
  );
  CameraPosition _kGooglePlex3 = CameraPosition(
    target: LatLng(17.9880426, 102.6057698),
    zoom: 16,
  );

  String namesakha = 'kkkk';

  late String text = widget.data.name;

  double longi = 10.00;

  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Marker _marker1 = Marker(
    markerId: MarkerId('myMarker'),
    position: LatLng(17.9219072, 102.7682240),
    infoWindow: InfoWindow(
        title: 'ສາຂາ1',
        onTap: () {
          print('Tap');
        }),
    icon: BitmapDescriptor.defaultMarker,
  );
  final Marker _marker2 = Marker(
    markerId: MarkerId('myMarker'),
    position: LatLng(18.0547392, 102.6795520),
    infoWindow: InfoWindow(
        title: 'ສາຂາ2',
        onTap: () {
          print('Tap');
        }),
    icon: BitmapDescriptor.defaultMarker,
  );
  final Marker _marker3 = Marker(
    markerId: MarkerId('myMarker'),
    position: LatLng(17.9880426, 102.6057698),
    infoWindow: InfoWindow(
        title: 'ສາຂາ3',
        onTap: () {
          print('Tap');
        }),
    icon: BitmapDescriptor.defaultMarker,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍລະອຽດສາຂາ',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.blue),
              child: GoogleMap(
                mapType: MapType.normal,
                markers: {widget.data.name.toString() == 'ສາຂາ1' ? _marker1 : widget.data.name.toString() == 'ສາຂາ2' ? _marker2 : _marker3},
                initialCameraPosition:widget.data.name.toString() == 'ສາຂາ1' ? _kGooglePlex1 : widget.data.name.toString() == 'ສາຂາ2' ? _kGooglePlex2:_kGooglePlex3,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            SizedBox(height: 20),
            Text(widget.data.name,
                style: TextStyle(
                    fontFamily: 'nsl_bold', color: Colors.black, fontSize: 20)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ຕິດຕໍ່ເບີ: ',
                        style: TextStyle(
                            fontFamily: 'nsl_bold',
                            color: Colors.black,
                            fontSize: 16)),
                    Text(widget.data.tel,
                        style: TextStyle(
                            fontFamily: 'nsl_bold',
                            color: Colors.black,
                            fontSize: 16)),
                  ],
                ),
                Container(
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => photo(context));
                      },
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                    ))
              ],
            ),
            Text('ສະຖານທີ່',
                style: TextStyle(
                    fontFamily: 'nsl_bold', color: Colors.black, fontSize: 20)),
            Text(widget.data.state,
                style: TextStyle(
                    fontFamily: 'nsl_bold',
                    color: Colors.grey.shade800,
                    fontSize: 16)),
            Text(widget.data.district,
                style: TextStyle(
                    fontFamily: 'nsl_bold',
                    color: Colors.grey.shade800,
                    fontSize: 16)),
            Text(widget.data.division,
                style: TextStyle(
                    fontFamily: 'nsl_bold',
                    color: Colors.grey.shade800,
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }

  CupertinoActionSheet photo(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              await launchUrl(Uri.parse('tel:/' + widget.data.tel));
              ;
            },
            child: Text('ໂທຫາເບີ: ' + widget.data.tel,
                style: TextStyle(fontFamily: 'nsl_bold', fontSize: 16))),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
