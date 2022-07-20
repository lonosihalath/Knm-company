import 'package:flutter/material.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/screen/callcenter/callcenter.dart';
import 'package:get/get.dart';
import 'package:knm/screen/home/detail_sakha.dart';

class SskhaData_Screen extends StatefulWidget {
  const SskhaData_Screen({Key? key}) : super(key: key);

  @override
  State<SskhaData_Screen> createState() => _SskhaData_ScreenState();
}

class _SskhaData_ScreenState extends State<SskhaData_Screen> {
  BranchController branchController = Get.put(BranchController());
  var currentSelectedValuecity;
  var currentSelectedValuestate;

  static var city = [
    "ຊຽງຄວນ",
    "ໄຊທານີ",
    "ຈັນທະບູລີ",
  ];
  static var states = [
    "ຊຽງຄວນ",
    "ໄຊສະຫວ່າງ",
    "ດົງປ່າແຫຼບ",
  ];
  
  static List<double> lng = [17.9208950,17.989437,18.0547392];
  static List<double> lat = [1027682342,102.608453,102.6795520];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            )),
        title: Text('ຂໍ້ມູນສາຂາ',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Callcenter_Screen()));
              },
              icon: Container(
                  width: 30,
                  height: 35,
                  child: Image.asset(
                    'images/callcenter.png',
                    color: Colors.white,
                  ))),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: List.generate(
                  branchController.statetList.length,
                  (index) => GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Detail_Sakha(
                        data: branchController.statetList[index],longitude: double.parse(lng[index].toString(),))));
                    },
                    child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          width: width,
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset('images/kong3.png')),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            branchController.statetList[index].name,
                                            style: const TextStyle(
                                                fontFamily: 'nsl_bold',
                                                fontSize: 18,
                                                color: Colors.black)),
                                        Text(branchController.statetList[index].state,
                                            style: const TextStyle(
                                                fontFamily: 'nsl_light',
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 30,
                                child: Image.asset('images/right.png', color: Colors.blue,),
                              )
                            ],
                          ),
                        ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Padding textfield(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontFamily: 'nsl_bold', fontSize: 18)),
        ],
      ),
    );
  }

  Container selectcity(double width) {
    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    city[0],
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuecity,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuecity = newValue;
                    });
                    print(currentSelectedValuecity);
                  },
                  items: city.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container selectstate(double width) {
    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    states[0],
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuestate,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuestate = newValue;
                    });
                    print(currentSelectedValuestate);
                  },
                  items: states.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container buttonregister(double screen) {
    return Container(
      width: screen * 0.90,
      margin: EdgeInsets.only(top: 15),
      height: 45,
      child: RaisedButton(
        color: Color.fromARGB(255, 10, 84, 188),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {},
        child: Text(
          'ຄົ້ນຫາ',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontFamily: 'nsl_regular'),
        ),
      ),
    );
  }
}
