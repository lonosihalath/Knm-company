import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:get/get.dart';
import 'package:knm/brand/widget.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/categories/widget.dart';
import 'package:knm/screen/order/order_controller.dart';
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

  TextEditingController controllernamephuhub = TextEditingController();
  TextEditingController controllersurnamephuhub = TextEditingController();
  TextEditingController controllernamephusong = TextEditingController();
  TextEditingController controllersurnamephusong = TextEditingController();
  TextEditingController controllernamephonephuhub = TextEditingController();
  TextEditingController controllernamephonephusong = TextEditingController();
  TextEditingController controllernameaddressphuhub = TextEditingController();
  TextEditingController controllernameaddressphusong = TextEditingController();
  TextEditingController controllerparcel = TextEditingController();
  TextEditingController controllertonthang = TextEditingController();
  TextEditingController controllerpaithang = TextEditingController();
  TextEditingController controllercategories = TextEditingController();
  TextEditingController controllernumnuk = TextEditingController();
  TextEditingController controllerwidthheight = TextEditingController();
  //TextEditingController _controllercategories = TextEditingController();
  BranchController branchController = Get.put(BranchController());
  OrderShowController orderShowController = Get.put(OrderShowController());
  CategoriesController categoriesController = Get.put(CategoriesController());
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
  var senderid;
  var recipientid;

    DateTime selectedDate = DateTime.now();

  _insertOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token')!;
    var id = preferences.getString('id')!;
    ////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////
    var data = {
      "user_id": id,
      "sender_id": senderid.toString(),
      "recipient_id": recipientid.toString(),
      "original_branch": idbranchtonthanhg,
      "destination_branch": idbranchtonpithang,
      "order_date": DateFormat('dd/MM/yyyy').format(selectedDate),
      "order_month":  DateFormat('MM').format(selectedDate),
      "order_year": DateFormat('yyyy').format(selectedDate),
      "status": "Hello world",
      "order_items": [
        {
          "category_id": idcategory,
          "parcel_name": controllerparcel.text,
          "weight": controllernumnuk.text,
          "width_height": controllerwidthheight.text,
        },
      ]
    };

    var resorder = await CallApiOrder().postDataupOrder(
      data,
      'insert',
      token,
    );
    print('Response status: ${resorder.body}');
    orderShowController.onInit();
  }

  _insertphuhub() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token')!;
    var id = preferences.getString('id')!;
    var dataphuhub = {
      "recipient_name": controllernamephuhub.text,
      "recipient_surname": controllersurnamephuhub.text,
      "recipient_tel": controllernamephonephuhub.text,
      "recipient_address": controllernameaddressphuhub.text,
    };

    var res = await CallApiOrder().postDataphuhub(
      dataphuhub,
      'insert',
      token,
    );
    var json = jsonDecode(res.body);
    print('Response status: ${json['user']['id']}');
    setState(() {
      recipientid = json['user']['id'];
    });
    //print(res.body['user']['id']);
    //orderShowController.onInit();
  }

  _insertphusong() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token')!;
    var id = preferences.getString('id')!;
    var datapuhsong = {
      "sender_name": controllernamephusong.text,
      "sender_surname": controllersurnamephusong.text,
      "sender_tel": controllernamephonephusong.text,
      "sender_address": controllernameaddressphusong.text,
    };

    var res = await CallApiOrder().postDataphusong(
      datapuhsong,
      'insert',
      token,
    );
    var json = jsonDecode(res.body);
    print('Response status: ${res.body}');
    setState(() {
      senderid = json['user']['id'];
      print(senderid);
      _insertOrder();
    });
    //orderShowController.onInit();
  }

  bool status = false;
  var idcategory;
  var idbranchtonthanhg;
  var idbranchtonpithang;
  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////////////////////////////
    List.generate(
        categoriesController.statetList.length,
        (index) => categoriesController.statetList[index].name ==
                currentSelectedValuecategories
            ? setState(() {
                idcategory = categoriesController.statetList[index].id;
                print(idcategory);
              })
            : print('0'));
    ////////////////////////////////////////////////////////////////////////////////
    List.generate(
       branchController.statetList.length,
        (index) => branchController.statetList[index].name ==
                currentSelectedValueTonthang
            ? setState(() {
                idbranchtonthanhg = branchController.statetList[index].id;
                print(idbranchtonthanhg);
              })
            : print('0'));
    ////////////////////////////////////////////////////////////////////////////////
    List.generate(
       branchController.statetList.length,
        (index) => branchController.statetList[index].name ==
                currentSelectedValuepiythang
            ? setState(() {
                idbranchtonpithang = branchController.statetList[index].id;
                print(idbranchtonpithang);
              })
            : print('0'));
    ////////////////////////////////////////////////////////////////////////////////
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
          'ຟາກເຄື່ອງດ້ວຍຕົນເອງ',
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
                height: 690,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 30),
                margin: const EdgeInsets.only(top: 100),
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: const Radius.circular(25))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      status == false
                          ? Column(
                              children: [
                                textfield('ຂໍ້ມູນຜູ້ສົ່ງ'),
                                const SizedBox(height: 5),
                                namephusong(width),
                                const SizedBox(height: 15),
                                surnamephusong(width),
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
                                addressphusong(width),
                                const SizedBox(height: 15),
                                textfield('ຂໍ້ມູນຜູ້ຮັບ'),
                                const SizedBox(height: 5),
                                namephuhub(width),
                                const SizedBox(height: 15),
                                surnamephuhub(width),
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
                                addressphuhub(width),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      const SizedBox(height: 10),
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
                              width:
                                  status == true ? width * 0.40 : width * 0.80,
                              height: 45,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      onPressed: () {
                                        if (status == true) {
                                          _insertphuhub();
                                          _insertphusong();
                                        }
                                        setState(() {
                                          status = true;
                                        });
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

  Container namephusong(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernamephusong,
          keyboardType: TextInputType.name,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ຊື່',
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

  Container surnamephusong(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllersurnamephusong,
          keyboardType: TextInputType.name,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ນາມສະກຸນ',
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

  Container namephuhub(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllernamephuhub,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ຊື່',
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

  Container surnamephuhub(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: controllersurnamephuhub,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ນາມສະກຸນ',
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
          controller: controllerwidthheight,
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
