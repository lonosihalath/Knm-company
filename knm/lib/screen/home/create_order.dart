import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:get/get.dart';
import 'package:knm/brand/widget.dart';
import 'package:knm/categories/widget.dart';
import 'package:knm/signin_signup/callApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  void initState() {
    super.initState();
    findUser();
  }

  late var Userid = '';
  late var Usertoken = '';
  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Usertoken = preferences.getString('token')!;
      Userid = preferences.getString('id')!;
    });
  }

  TextEditingController controllername = TextEditingController();
  TextEditingController controllernamephonephuhub = TextEditingController();
  TextEditingController controllernamephonephusong = TextEditingController();
  TextEditingController controllernameaddressphuhub = TextEditingController();
  TextEditingController controllernameaddressphusong = TextEditingController();
  TextEditingController controllerparcel = TextEditingController();
  TextEditingController controllertonthang = TextEditingController();
  TextEditingController controllerpaithang = TextEditingController();
  TextEditingController controllercategories = TextEditingController();
  TextEditingController controllernumnuk = TextEditingController();
  //TextEditingController _controllercategories = TextEditingController();
  BranchController branchController = Get.put(BranchController());
  var currentSelectedValuetelphuhub;
  var currentSelectedValuetelphusong;
  var currentSelectedValueTonthang;
  var currentSelectedValuepiythang;
  var currentSelectedValuecategories;
  late int _selectedAddress1 = 1;
  static var tel = [
    "020",
    "030",
  ];
  _insertOrder() async {
    var data = {
      'user_id': Userid.toString(),
      'recipient_id': '1',
      'original_branch': '1',
      'destination_branch': '2',
      'order_date': '3/02/2022',
      'order_month': 'Februay',
      'order_year': '2022',
      'status': "Hello world",
      'order_items': [
        {
          'order_id': '1',
          'category_id': '1',
          'parcel_name': 'VutSaDu',
          'weight': '10',
          'width': '50',
          'height': '50'
        },
      ]
    };

    var res = await CallApiOrder().postDataupOrder(
      data,
      'order/insert',
      Usertoken,
    );
    var body = json.decode(res.body);
    print(body);
  }

  bool status = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            )),
        title: const Text(
          'ສ້າງໃບບິນດ້ວຍຕົນເອງ',
          style: const TextStyle(
              fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22),
        ),
        // actions: [
        //   Container(
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(right: 15),
        //     width: 100,
        //     decoration: BoxDecoration(
        //         color: Color.fromARGB(255, 18, 44, 243),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Text('ບັນທຶກ',
        //         style: TextStyle(
        //             fontFamily: 'nsl_bold', color: Colors.white, fontSize: 20)),
        //   )
        //],
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: const AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 120),
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: const Radius.circular(25))),
                child: Column(
                  children: [
                    status == false
                        ? Column(
                            children: [
                              textfield('ຂໍ້ມູນຜູ້ສົ່ງ'),
                              const SizedBox(height: 5),
                              name(width),
                              const SizedBox(height: 15),
                              Container(
                                width: width,
                                child: Row(
                                  children: [
                                    selecttelphusong(width),
                                    const SizedBox(width: 15),
                                    phonephusong(width)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              addressphuhub(width),
                              const SizedBox(height: 15),
                              textfield('ຂໍ້ມູນຜູ້ຮັບ'),
                              const SizedBox(height: 5),
                              name(width),
                              const SizedBox(height: 15),
                              Container(
                                width: width,
                                child: Row(
                                  children: [
                                    selecttelphuhub(width),
                                    const SizedBox(width: 15),
                                    phonephuhub(width)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              addressphusong(width),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),
                    status == true
                        ? Column(
                            children: [
                              textfield('ຂໍ້ມູນພັດສະດຸ'),
                              const SizedBox(height: 10),
                              namepasadu(width),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       border: Border.all(
                              //           width: 2, color: Colors.grey)),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Row(
                              //         children: [
                              //           Radio(
                              //               activeColor: Colors.lightBlue,
                              //               value: 1,
                              //               groupValue: _selectedAddress1,
                              //               toggleable: true,
                              //               onChanged: (int? val) {
                              //                 setState(() {
                              //                   _selectedAddress1 = val!;
                              //                   print(val);
                              //                 });
                              //               }),
                              //           textfiled2('ພັດສະດຸທົ່ວໄປ'),
                              //         ],
                              //       ),
                              //       Row(
                              //         children: [
                              //           Radio(
                              //               activeColor: Colors.lightBlue,
                              //               value: 2,
                              //               groupValue: _selectedAddress1,
                              //               toggleable: true,
                              //               onChanged: (int? val) {
                              //                 setState(() {
                              //                   _selectedAddress1 = val!;
                              //                   print(val);
                              //                 });
                              //               }),
                              //           textfiled2('ເອກະສານ'),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  selectsakhaTonthang(width),
                                  selectsakhapiythang(width)
                                ],
                              ),
                              const SizedBox(height: 17),
                              categorie(width),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [widthheigth(width), numnuk(width)],
                              ),
                              const SizedBox(height: 17),
                              Container(
                                width: width,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1, color: Colors.red)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('ໝາຍເຫດ',
                                        style: TextStyle(
                                            fontFamily: 'nsl_bold',
                                            fontSize: 20,
                                            color: Colors.red)),
                                    const Text(
                                        'ຄ່າບໍລິການແມ່ນຕ້ອງອິງຕາມການຄິດໄລ່ຕົວຈິງຂອງພະນັກງານ ເຄເອັນເອັມ',
                                        style: const TextStyle(
                                            fontFamily: 'nsl_bold',
                                            fontSize: 14)),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: status == true
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        status == true
                            ? Container(
                                width: status == true
                                    ? width * 0.40
                                    : width * 0.80,
                                height: 45,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            status = false;
                                          });
                                        },
                                        child: const Text(
                                          'ຍ້ອນກັບ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ))))
                            : const Text(''),
                        Container(
                            width: status == true ? width * 0.40 : width * 0.80,
                            height: 45,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        status = true;
                                      });
                                      _insertOrder();
                                    },
                                    child: const Text(
                                      'ຢືນຢັນ',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Padding textfiled2(text) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(text,
            style: const TextStyle(fontFamily: 'nsl_bold', fontSize: 15)),
      );

  Padding textfield(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(text,
              style: const TextStyle(fontFamily: 'nsl_bold', fontSize: 18)),
        ],
      ),
    );
  }

  Container name(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllername,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ຊື່ຜູ້ສົ່ງ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container namepasadu(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllerparcel,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ປ້ອນຊື່ພັດສະດຸ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container selecttelphuhub(double width) {
    return Container(
      width: width * 0.22,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    tel[0],
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuetelphuhub,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuetelphuhub = newValue;
                    });
                    print(currentSelectedValuetelphuhub);
                  },
                  items: tel.map((String value) {
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

  Container selecttelphusong(double width) {
    return Container(
      width: width * 0.22,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    tel[0],
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuetelphusong,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuetelphusong = newValue;
                    });
                    print(currentSelectedValuetelphusong);
                  },
                  items: tel.map((String value) {
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

  Container phonephusong(double screen) {
    return Container(
      width: screen * 0.60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernamephonephusong,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: const InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container phonephuhub(double screen) {
    return Container(
      width: screen * 0.60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernamephonephuhub,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: const InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container addressphuhub(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernameaddressphuhub,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            hintText: 'ທີ່ຢູ່ປັດຈຸບັນຜູ້ຮັບ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container addressphusong(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernameaddressphusong,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            hintText: 'ທີ່ຢູ່ປັດຈຸບັນຜູ້ສົ່ງ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container selectsakhaTonthang(double width) {
    return Container(
      width: width * 0.40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    'ເລືອກສາຂາຕົ້ນທາງ',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValueTonthang,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValueTonthang = newValue;
                    });
                    print(currentSelectedValueTonthang);
                  },
                  items: sakha.map((String value) {
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

  Container selectsakhapiythang(double width) {
    return Container(
      width: width * 0.40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    'ເລືອກສາຂາປາຍທາງ',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuepiythang,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuepiythang = newValue;
                    });
                    print(currentSelectedValuepiythang);
                  },
                  items: sakha.map((String value) {
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

  Container categorie(double width) {
    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    'ເລືອກໝວດໝູ່ເຄື່ອງ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuecategories,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuecategories = newValue;
                    });
                    print(currentSelectedValuecategories);
                  },
                  items: categories.map((String value) {
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

  Container widthheigth(double screen) {
    return Container(
      width: screen * 0.40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ກ້ວາງ + ສູງ +ຍາວ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container numnuk(double screen) {
    return Container(
      width: screen * 0.40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernumnuk,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ນໍ້າໜັກຂອງພັດສະດຸ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: const Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
