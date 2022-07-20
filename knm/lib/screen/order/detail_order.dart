// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/brand/model.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/categories/model.dart';
import 'package:knm/screen/order/Recipient/model.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/screen/order/show_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailOrder extends StatefulWidget {
  final String idrecipient;
  final String idsender;
  final String idorder;
  final String idinvoid;
  final String idcategories;
  final String tonthang;
  final String piythang;
  final List<OrderItem> orderItem;
  final status;
  //final String idsender;
  const DetailOrder(
      {Key? key,
      required this.idrecipient,
      required this.idsender,
      required this.idorder,
      required this.idinvoid,
      required this.tonthang,
      required this.idcategories,
      required this.piythang,
      required this.orderItem, required this.status})
      : super(key: key);

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  BranchController branchController = Get.put(BranchController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  var recipientList = <Recipient>[].obs;
  var senderList = <Sender>[].obs;
  var isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    fetchAlbumData();
  }

  Timer? _timer;
  OrderShowController orderShowController = Get.put(OrderShowController());

  void data() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      orderShowController.onInit();
    });
  }

  Future<void> fetchAlbumData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8000/api/recipient/show/${widget.idrecipient}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      print('======> ' + '${response.statusCode}');
      print('======> ' + '${response.body}');
      Recipient _albumModel = Recipient.fromJson(jsonDecode(response.body));
      recipientList.add(
        Recipient(
          id: _albumModel.id,
          name: _albumModel.name,
          surname: _albumModel.surname,
          tel: _albumModel.tel,
          address: _albumModel.address,
        ),
      );
      //////////////////////////////////////////////////////////////////////////
      final responsedata = await http.get(
          Uri.parse(
              'http://10.0.2.2:8000/api/sender/show/${widget.idsender}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (responsedata.statusCode == 200) {
        print('======> ' + '${responsedata.statusCode}');
        print('======> ' + '${responsedata.body}');
        Sender _albumModel = Sender.fromJson(jsonDecode(responsedata.body));
        senderList.add(
          Sender(
            id: _albumModel.id,
            name: _albumModel.name,
            surname: _albumModel.surname,
            tel: _albumModel.tel,
            address: _albumModel.address,
          ),
        );
      }
      isLoading.value = false;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('ລາຍລະອຽດພັດສະດຸ', style: TextStyle(
                                  fontSize: 20, fontFamily: 'nsl_bold')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade100,
            child: Obx(() {
              if (isLoading.value)
                return Column(
                  children: [
                    SizedBox(height: 100),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ລະຫັດພັດສະດຸ : ${widget.idinvoid}',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'nsl_bold')),
                          widget.status.toString() == 'Pending' ?
                          Container(
                            width: 100,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red, elevation: 0),
                                child: Text(
                                  'ຍົກເລີກ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) => dialog(
                                          context, widget.idorder.toString()));
                                },
                              ),
                            ),
                          ) : Container()
                        ],
                      ),

                      Text('ຂໍ້ມູນການຂົນສົ່ງ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'nsl_bold',
                              color: Colors.black)),
                      SizedBox(height: 5,),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 7),
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              databrand(
                                  branchController.statetList
                                      .where((p0) =>
                                          p0.id.toString() == widget.tonthang)
                                      .toList(),
                                  'ສາຂາຕົ້ນທາງ: '),
                              databrand(
                                  branchController.statetList
                                      .where((p0) =>
                                          p0.id.toString() == widget.piythang)
                                      .toList(),
                                  'ສາຂາປາຍທາງ: '),
                            ],
                          ),
                        ),
                      ),
                      Text('ຂໍ້ມູນເຄື່ອງຟາກ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'nsl_bold',
                              color: Colors.black)),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 7),
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                widget.orderItem.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text('ສິນຄ້າທີ:      ${index + 1}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'nsl_bold',
                                            color: Colors.black)),
                                    SizedBox(height: 3),
                                    Text('ຊື່ພັດສະດຸ:     ' +
                                        widget.orderItem[index].attribute!
                                            .parcelName
                                            .toString()),
                                    Text('ນໍ້າໜັກ:     ' +
                                        widget
                                            .orderItem[index].attribute!.weight
                                            .toString() +
                                        ' km'),
                                    Text('ລວງຍາວ+ລວງສູງ:     ' +
                                        widget.orderItem[index].attribute!
                                            .widthHeigth
                                            .toString() +
                                        ' cm'),
                                    datacategory(
                                        categoriesController.statetList
                                            .where((p0) =>
                                                p0.id.toString() ==
                                                widget.orderItem[index]
                                                    .attribute!.categoryId)
                                            .toList(),
                                        'ປະເພດສິນຄ້າ:      '),
                                    SizedBox(height: 7),
                                    Container(
                                      width: width,
                                      height: 2,
                                      color: Colors.grey.shade400,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Text('ຂໍ້ມູນຜູ້ສົ່ງ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'nsl_bold',
                              color: Colors.black)),
                      datasender(width),
                      Text('ຂໍ້ມູນຜູ້ຮັບ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'nsl_bold',
                              color: Colors.black)),
                      datarecipient(width),
                    ],
                  ),
                );
              }
            }),
          ),
        ));
  }

  Text databrand(List<Brand> brand, text) {
    return Text(text + brand[0].name,
        style: TextStyle(fontSize: 16, fontFamily: 'nsl_regular'));
  }

  Text datacategory(List<Categories> categories, text) {
    return Text(text + categories[0].name,
        style: TextStyle(fontSize: 16, fontFamily: 'nsl_regular'));
  }

  Container datarecipient(double width) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 7),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ຊື່:     ' + recipientList[0].name,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ນາມສະກຸນ:     ' + recipientList[0].surname,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ເບີໂທຕິດຕໍ່:     ' + recipientList[0].tel,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ທີ່ຢູ່:     ' + recipientList[0].address,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
          ],
        ),
      ),
    );
  }

  Container datasender(double width) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 7),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ຊື່:     ' + senderList[0].name,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ນາມສະກຸນ:     ' + senderList[0].surname,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ເບີໂທຕິດຕໍ່:     ' + senderList[0].tel,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
            Text('ທີ່ຢູ່:     ' + senderList[0].address,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontFamily: 'nsl_regular',
                )),
          ],
        ),
      ),
    );
  }

  Future<http.Response> deleteData(String id) async {
    orderShowController.statetList.clear();
    showDialog(context: context, builder: (context) => dialog3());
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    final http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/order/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('object');
      orderShowController.onInit();
      Future.delayed(Duration(seconds: 4), () {
        orderShowController.onInit();
        Navigator.pop(context);
        _timer!.cancel();
        Navigator.pop(context);
        orderShowController.onInit();
      });
    } else {
      print('object');
      _timer!.cancel();
    }
    return response;
  }

  Widget dialog3() => const CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text('ກະລຸນາລໍຖ້າ')),
        ),
      );

  Widget dialog(BuildContext context, String id) => CupertinoAlertDialog(
        title: Text(''),
        content: Text('ທ່ານຕ້ອງການຍົກເລີກລາຍການນີ້ຫຼືບໍ່?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              data();
              deleteData(id.toString());
            },
          ),
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
}
