import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Detail_Sakha extends StatefulWidget {
  final data;
  const Detail_Sakha({Key? key, required this.data}) : super(key: key);

  @override
  State<Detail_Sakha> createState() => _Detail_SakhaState();
}

class _Detail_SakhaState extends State<Detail_Sakha> {
  Completer<GoogleMapController> _controller = Completer();

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.9526693, 102.6207602),
    zoom: 16,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
                initialCameraPosition: _kGooglePlex,
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
                      onPressed: () {},
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
