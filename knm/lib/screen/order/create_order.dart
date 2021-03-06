import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:get/get.dart';
import 'package:knm/brand/widget.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/categories/widget.dart';
import 'package:knm/screen/home/homepage.dart';
import 'package:knm/screen/order/controller_orderitem.dart';
import 'package:knm/screen/order/orderItemDetail.dart';
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
    currentSelectedValuetelphuhub = tel[0];
    currentSelectedValuetelphusong = tel[0];
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
  final OrderItemController orderItemController =
      Get.put(OrderItemController());
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
  ///////////////////////////////////////////////////

  ///////////////////////////////////////////////////
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
      "order_month": DateFormat('MM').format(selectedDate),
      "order_year": DateFormat('yyyy').format(selectedDate),
      "status": "Hello world",
      "order_items":
          //  orderItemController.items.length.toInt() != 0
          //     ? List.generate(
          //         orderItemController.items.length,
          //         (index) => {
          //           "category_id": orderItemController.items.values
          //               .toList()[index]
          //               .categoryId
          //               .toString(),
          //           "parcel_name": orderItemController.items.values
          //               .toList()[index]
          //               .parcelname
          //               .toString(),
          //           "weight": orderItemController.items.values
          //               .toList()[index]
          //               .weight
          //               .toString(),
          //           "width_height": orderItemController.items.values
          //               .toList()[index]
          //               .widthheight
          //               .toString(),
          //         },
          //       )
          //     :
          [
        {
          "category_id": idcategory.toString(),
          "parcel_name": controllerparcel.text.toString(),
          "weight": controllernumnuk.text.toString(),
          "width_height": controllerwidthheight.text.toString(),
        }
      ],
    };

    var resorder = await CallApiOrder().postDataupOrder(
      data,
      'insert',
      token,
    );
    print('Response status: ${resorder.statusCode}');
    if (resorder.statusCode == 200) {
      orderItemController.clear();
      orderShowController.onInit();
      Future.delayed(Duration(seconds: 3), () {
        orderShowController.onInit();
        Navigator.pop(context);
        Get.snackbar('???????????????????????????????????????', '?????????????????????????????? !!!',
            snackPosition: SnackPosition.TOP);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (lono) => HomePage_Screen()));
      });
    }
  }

  _insertphuhub() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token')!;
    var id = preferences.getString('id')!;
    var dataphuhub = {
      "recipient_name": controllernamephuhub.text,
      "recipient_surname": controllersurnamephuhub.text,
      "recipient_tel": currentSelectedValuetelphuhub.toString() +
          controllernamephonephuhub.text,
      "recipient_address": controllernameaddressphuhub.text,
    };

    var res = await CallApiOrder().postDataphuhub(
      dataphuhub,
      'insert',
      token,
    );
    var json = jsonDecode(res.body);
    //var json1 = jsonDecode(res.StatusCode);
    print('Response status: ${json}');
    print('Response status: ${json['Recipient']['id']}');
    setState(() {
      recipientid = json['Recipient']['id'];
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
      "sender_tel": currentSelectedValuetelphusong.toString() +
          controllernamephonephusong.text,
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
      senderid = json['Sender']['id'];
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
              orderItemController.clear();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            )),
        title: const Text(
          '?????????????????????????????????????????????????????????',
          style: TextStyle(
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
        //     child: Text('??????????????????',
        //         style: TextStyle(
        //             fontFamily: 'nsl_bold', color: Colors.white, fontSize: 20)),
        //   )
        //],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: const AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              margin: const EdgeInsets.only(top: 100),
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
                            textfield('???????????????????????????????????????'),
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
                            textfield('????????????????????????????????????'),
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
                            textfield('??????????????????????????????'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectsakhaTonthang(width),
                                selectsakhapiythang(width)
                              ],
                            ),
                            const SizedBox(height: 10),
                            textfield('???????????????????????????????????????'),
                            const SizedBox(height: 10),
                            namepasadu(width),
                            const SizedBox(height: 17),
                            categorie(width),
                            const SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [widthheigth(width), numnuk(width)],
                            ),
                            const SizedBox(height: 17),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       width: width * 0.50,
                            //       height: 45,
                            //       child: ElevatedButton(
                            //         onPressed: () {
                            //           if (controllerparcel.text.length
                            //                   .toInt() ==
                            //               0) {
                            //             showDialog(
                            //                 context: context,
                            //                 builder: (lono) => dialog(context,
                            //                     '????????????????????????????????????????????????????????????'));
                            //           } else {
                            //             if (currentSelectedValuecategories ==
                            //                 null) {
                            //               showDialog(
                            //                   context: context,
                            //                   builder: (lono) => dialog(context,
                            //                       '?????????????????????????????????????????????????????????????????????'));
                            //             } else {
                            //               if (controllerwidthheight.text.length
                            //                       .toInt() ==
                            //                   0) {
                            //                 showDialog(
                            //                     context: context,
                            //                     builder: (lono) => dialog(
                            //                         context,
                            //                         '???????????????????????????????????????????????? + ???????????????????????? + ??????????????????'));
                            //               } else {
                            //                 if (controllernumnuk.text.length
                            //                         .toInt() ==
                            //                     0) {
                            //                   showDialog(
                            //                       context: context,
                            //                       builder: (lono) => dialog(
                            //                           context,
                            //                           '????????????????????????????????????????????????????????????'));
                            //                 } else {
                            //                   var number = int.parse(Random()
                            //                       .nextInt(1000)
                            //                       .toString());

                            //                   orderItemController.addItem(
                            //                     2022 + number,
                            //                     idcategory.toString(),
                            //                     controllerparcel.text
                            //                         .toString(),
                            //                     controllernumnuk.text
                            //                         .toString(),
                            //                     controllerwidthheight.text
                            //                         .toString(),
                            //                   );
                            //                   setState(() {
                            //                     controllerparcel.text = '';
                            //                     controllernumnuk.text = '';
                            //                     controllerwidthheight.text = '';
                            //                   });
                            //                 }
                            //               }
                            //             }
                            //           }
                            //         },
                            //         child: Text(
                            //           '????????????????????????????????????',
                            //           style: TextStyle(
                            //             fontFamily: 'nsl_bold',
                            //             fontSize: 15,
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Stack(
                            //       children: [
                            //         IconButton(
                            //             onPressed: () {
                            //               Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           OrderItemDetail()));
                            //             },
                            //             icon: Icon(
                            //               Icons.shopping_cart,
                            //               color: Colors.grey,
                            //               size: 35,
                            //             )),
                            //         GetBuilder<OrderItemController>(
                            //             init: OrderItemController(),
                            //             builder: (cont) =>
                            //                 Column(children: <Widget>[
                            //                   orderItemController
                            //                           .items.isNotEmpty
                            //                       ? Positioned(
                            //                           child: Container(
                            //                           alignment:
                            //                               Alignment.center,
                            //                           width: 20,
                            //                           height: 20,
                            //                           decoration: BoxDecoration(
                            //                             color: Colors.red,
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .circular(10),
                            //                           ),
                            //                           child: Text(
                            //                             orderItemController
                            //                                 .items.length
                            //                                 .toString(),
                            //                             style: TextStyle(
                            //                                 color: Colors.white,
                            //                                 fontSize: 10,
                            //                                 fontWeight:
                            //                                     FontWeight
                            //                                         .bold),
                            //                           ),
                            //                         ))
                            //                       : Container(),
                            //                 ])),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 5),
                            // Row(
                            //   children: [
                            //     Text(
                            //       '????????????????????????????????????????????????????????????????????? 1 ?????????????????????',
                            //       style: TextStyle(
                            //           fontFamily: 'nsl_bold',
                            //           fontSize: 13,
                            //           color: Colors.grey.shade800),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 15),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(bottom: 25),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.red)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text('??????????????????',
                                      style: TextStyle(
                                          fontFamily: 'nsl_bold',
                                          fontSize: 20,
                                          color: Colors.red)),
                                  const Text(
                                      '?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ??????????????????????????????',
                                      style: const TextStyle(
                                          fontFamily: 'nsl_bold',
                                          fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: status == true
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      status == true
                          ? Container(
                              width:
                                  status == true ? width * 0.40 : width * 0.80,
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
                                        '?????????????????????',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
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
                                    if (status == true) {
                                      // if (orderItemController.items.length
                                      //         .toInt() ==
                                      //     0) {
                                      if (currentSelectedValueTonthang ==
                                          null) {
                                        showDialog(
                                            context: context,
                                            builder: (lono) => dialog(context,
                                                '??????????????????????????????????????????????????????????????????'));
                                      } else {
                                        if (currentSelectedValuepiythang ==
                                            null) {
                                          showDialog(
                                              context: context,
                                              builder: (lono) => dialog(context,
                                                  '???????????????????????????????????????????????????????????????'));
                                        } else {
                                          if (controllerparcel.text.length
                                                  .toInt() ==
                                              0) {
                                            showDialog(
                                                context: context,
                                                builder: (lono) => dialog(
                                                    context,
                                                    '????????????????????????????????????????????????????????????'));
                                          } else {
                                            if (currentSelectedValuecategories ==
                                                null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (lono) => dialog(
                                                      context,
                                                      '?????????????????????????????????????????????????????????????????????'));
                                            } else {
                                              if (controllerwidthheight
                                                      .text.length
                                                      .toInt() ==
                                                  0) {
                                                showDialog(
                                                    context: context,
                                                    builder: (lono) => dialog(
                                                        context,
                                                        '???????????????????????????????????????????????? + ???????????????????????? + ??????????????????'));
                                              } else {
                                                if (controllernumnuk.text.length
                                                        .toInt() ==
                                                    0) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (lono) => dialog(
                                                          context,
                                                          '????????????????????????????????????????????????????????????'));
                                                } else {
                                                  _insertphuhub();
                                                  _insertphusong();
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          dialog3());
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                      // } else {
                                      //   _insertphuhub();
                                      //   _insertphusong();
                                      //   showDialog(
                                      //       context: context,
                                      //       builder: (context) => dialog3());
                                      // }
                                    }
                                    if (controllernamephusong.text.length
                                                .toInt() ==
                                            0 &&
                                        controllersurnamephusong
                                                .text.length
                                                .toInt() ==
                                            0 &&
                                        controllernamephonephusong
                                                .text.length
                                                .toInt() ==
                                            0 &&
                                        controllernameaddressphusong
                                                .text.length
                                                .toInt() ==
                                            0 &&
                                        controllernamephuhub.text.length
                                                .toInt() ==
                                            0 &&
                                        controllersurnamephuhub.text.length
                                                .toInt() ==
                                            0 &&
                                        controllernamephonephuhub.text.length
                                                .toInt() ==
                                            0 &&
                                        controllernameaddressphuhub.text.length
                                                .toInt() ==
                                            0) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (lono) => dialog(
                                              context, '????????????????????????????????????????????????'));
                                    } else {
                                      if (controllernamephusong.text.length
                                              .toInt() ==
                                          0) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (lono) => dialog(context,
                                                '????????????????????????????????????????????????????????????'));
                                      } else {
                                        if (controllersurnamephusong.text.length
                                                .toInt() ==
                                            0) {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (lono) => dialog(context,
                                                  '???????????????????????????????????????????????????????????????????????????'));
                                        } else {
                                          if (controllernamephonephusong
                                                  .text.length
                                                  .toInt() ==
                                              0) {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (lono) => dialog(
                                                    context,
                                                    '??????????????????????????????????????????????????????????????????'));
                                          } else {
                                            if (controllernameaddressphusong
                                                    .text.length
                                                    .toInt() ==
                                                0) {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (lono) => dialog(
                                                      context,
                                                      '?????????????????????????????????????????????????????????????????????'));
                                            } else {
                                              if (controllernamephuhub
                                                      .text.length
                                                      .toInt() ==
                                                  0) {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (lono) => dialog(
                                                        context,
                                                        '?????????????????????????????????????????????????????????'));
                                              } else {
                                                if (controllersurnamephuhub
                                                        .text.length
                                                        .toInt() ==
                                                    0) {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (lono) => dialog(
                                                          context,
                                                          '????????????????????????????????????????????????????????????????????????'));
                                                } else {
                                                  if (controllernamephonephuhub
                                                          .text.length
                                                          .toInt() ==
                                                      0) {
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (lono) => dialog(
                                                            context,
                                                            '???????????????????????????????????????????????????????????????'));
                                                  } else {
                                                    if (controllernameaddressphuhub
                                                            .text.length
                                                            .toInt() ==
                                                        0) {
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (lono) => dialog(
                                                              context,
                                                              '??????????????????????????????????????????????????????????????????'));
                                                    } else {
                                                      setState(() {
                                                        status = true;
                                                        categoriesController
                                                            .onInit();
                                                      });
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: const Text(
                                    '??????????????????',
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
      ),
    );
  }

  Widget dialog3() => const CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text('?????????????????????????????????')),
        ),
      );

  CupertinoAlertDialog dialog(BuildContext context, String text) {
    return CupertinoAlertDialog(
      title: Column(
        children: [],
      ),
      content: Text(
        text,
        style: TextStyle(fontFamily: 'nsl_regular', fontSize: 15),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('??????????????????'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
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
            hintText: '?????????',
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
            hintText: '????????????????????????',
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
            hintText: '?????????',
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
            hintText: '????????????????????????',
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
            hintText: '??????????????????????????????????????????',
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
          keyboardType: TextInputType.name,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            hintText: '????????????????????????????????????????????????????????????',
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
          keyboardType: TextInputType.name,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            fillColor: const Color(0xFFF4F6FB),
            hintText: '???????????????????????????????????????????????????????????????',
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
      width: width * 0.43,
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
                      fontSize: 12.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    '????????????????????????????????????????????????',
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
                  items: currentSelectedValuepiythang.toString() ==
                          '????????????1 ( ???????????? ?????????????????? )'
                      ? sakha21.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : currentSelectedValuepiythang.toString() ==
                              '????????????2 ( ???????????? ??????????????????????????? )'
                          ? sakha22.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : currentSelectedValuepiythang.toString() ==
                                  '????????????3 ( ???????????? ?????????????????????????????? )'
                              ? sakha23.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                              : sakha.map((String value) {
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
      width: width * 0.43,
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
                      fontSize: 12.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    '?????????????????????????????????????????????',
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
                  items: currentSelectedValueTonthang.toString() ==
                          '????????????1 ( ???????????? ?????????????????? )'
                      ? sakha21.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : currentSelectedValueTonthang.toString() ==
                              '????????????2 ( ???????????? ??????????????????????????? )'
                          ? sakha22.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : currentSelectedValueTonthang.toString() ==
                                  '????????????3 ( ???????????? ?????????????????????????????? )'
                              ? sakha23.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                              : sakha.map((String value) {
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
                    '???????????????????????????????????????????????????',
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
            hintText: '??????????????? + ????????? +?????????',
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
            hintText: '???????????????????????????????????????????????????',
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
