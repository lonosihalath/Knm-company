// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Order_Tacking extends StatefulWidget {
  Order_Tacking({
    Key? key,
  }) : super(key: key);

  @override
  _Order_TackingState createState() => _Order_TackingState();
}

class _Order_TackingState extends State<Order_Tacking> {
  Enum stepstate = StepState.complete;
  
  int _currentStep = 0;
  final _listState = [
    StepState.indexed,
    StepState.complete,
  ];
  DateTime dateTime1 = DateTime.now();
  DateTime dateTime2 = DateTime.now();
  DateTime dateTime3 = DateTime.now();
  DateTime dateTime4 = DateTime.now();
  DateTime dateTime5 = DateTime.now();
  DateTime dateTime6 = DateTime.now();
  DateTime dateTime7 = DateTime.now();
  //////////////
  bool status1 = true;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'ຕິດຕາມເຄື່ອງ',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'nsl_bold',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                   Row(
                        children: [
                          Text(
                            'Order ID: ' + '1',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'branding4',
                                color: Color(0xFF717171),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 25),
                timelineRow("Pending Orders", DateTime.now().toString()),
                status2 == true
                    ? timelineRow("Confirmed Orders", DateTime.now().toString())
                    : timelineRow2("Confirmed Orders", ""),
                status3 == true
                    ? timelineRow("Processing Orders", DateTime.now().toString())
                    : timelineRow2("Processing Orders", ""),
                status4 == true
                    ? timelineRow("Picked Orders", DateTime.now().toString())
                    : timelineRow2("Picked Orders", ""),
                // status7 == true
                //     ? timelineRow("Canceled Orders", DateTime.now().toString())
                //     : timelineRow2("Canceled Orders", ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget timelineRow(String title, String subTile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 25,
                height: 25,
                decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white),
              ),
              Container(
                width: 5,
                height: 50,
                decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.rectangle,
                ),
                child: Text(""),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${title}',
                  style: TextStyle(
                      fontFamily: "regular",
                      fontSize: 15,
                      color: Color(0xFF00ACE6))),
              SizedBox(
                height: 5,
              ),
              Text('${subTile}',
                  style: TextStyle(
                      fontFamily: "regular",
                      fontSize: 14,
                      color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

  Widget timelineRow2(String title, String subTile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Text(""),
              ),
              Container(
                width: 5,
                height: 50,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                ),
                child: Text(""),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${title}\n ${subTile}',
                  style: TextStyle(
                      fontFamily: "regular",
                      fontSize: 14,
                      color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

  Widget timelineLastRow(String title, String subTile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 18,
                height: 18,
                decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: Text(""),
              ),
              Container(
                width: 3,
                height: 20,
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                ),
                child: Text(""),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${title}\n ${subTile}',
                  style: TextStyle(
                      fontFamily: "regular",
                      fontSize: 14,
                      color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}
