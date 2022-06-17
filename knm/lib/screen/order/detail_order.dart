// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/brand/model.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/categories/model.dart';
import 'package:knm/screen/order/Recipient/model.dart';
import 'package:knm/screen/order/show_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailOrder extends StatefulWidget {
  final String idrecipient;
  final String idorder;
  final String idcategories;
  final String tonthang;
  final String piythang;
  final List<OrderItem> orderItem;
  //final String idsender;
  const DetailOrder(
      {Key? key,
      required this.idrecipient,
      required this.idorder,
      required this.tonthang,
      required this.idcategories,
      required this.piythang,
      required this.orderItem})
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
              'http://10.0.2.2:8000/api/sender/show/${widget.idrecipient}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (responsedata.statusCode == 200) {
        print('======> ' + '${responsedata.statusCode}');
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
          title: Text('ລາຍລະອຽດອໍເດີ້'),
          centerTitle: true,
        ),
        body: Container(
         color: Colors.grey.shade100,
          child: Obx(() {
            if (isLoading.value)
              return Center(child: CircularProgressIndicator());
            else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ໄອດີພັດສະດຸ : ${widget.idorder}',
                        style: TextStyle(fontSize: 18, fontFamily: 'nsl_bold')),
                    databrand(
                        branchController.statetList
                            .where((p0) => p0.id.toString() == widget.tonthang)
                            .toList(),
                        'ສາຂາຕົ້ນທາງ: '),
                    databrand(
                        branchController.statetList
                            .where((p0) => p0.id.toString() == widget.piythang)
                            .toList(),
                        'ສາຂາປາຍທາງ: '),
                    Text('ຂໍ້ມູນເຄື່ອງຟາກ',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'nsl_bold',
                            color: Colors.black)),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ຊື່ພັດສະດຸ: ' +
                                widget.orderItem[0].attribute!.parcelName
                                    .toString()),
                            Text('ນໍ້າໜັກ: ' +
                                widget.orderItem[0].attribute!.weight
                                    .toString() +
                                ' km'),
                            Text('ລວງຍາວ+ລວງສູງ: ' +
                                widget.orderItem[0].attribute!.widthHeigth
                                    .toString() +
                                ' cm'),
                            datacategory(
                                categoriesController.statetList
                                    .where((p0) =>
                                        p0.id.toString() == widget.idcategories)
                                    .toList(),
                                'ປະເພດສິນຄ້າ: ')
                          ],
                        ),
                      ),
                    ),
                    Text('ຂໍ້ມູນຜູ້ສົ່ງ',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'nsl_bold',
                            color: Colors.black)),
                    datasender(),
                    Text('ຂໍ້ມູນຜູ້ຮັບ',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'nsl_bold',
                            color: Colors.black)),
                    datarecipient()
                  ],
                ),
              );
            }
          }),
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

  Padding datarecipient() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ຊື່: ' + recipientList[0].name,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ນາມສະກຸນ: ' + recipientList[0].surname,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ເບີໂທຕິດຕໍ່: ' + recipientList[0].tel,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ທີ່ຢູ່: ' + recipientList[0].address,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
        ],
      ),
    );
  }

  Padding datasender() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ຊື່: ' + senderList[0].name,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ນາມສະກຸນ: ' + senderList[0].surname,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ເບີໂທຕິດຕໍ່: ' + senderList[0].tel,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
          Text('ທີ່ຢູ່: ' + senderList[0].address,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontFamily: 'nsl_regular',
              )),
        ],
      ),
    );
  }
}
