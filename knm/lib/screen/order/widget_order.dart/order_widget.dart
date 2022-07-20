import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm/screen/order/detail_order.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/screen/order/show_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderWidget extends StatefulWidget {
  final double width;
  final List<OrdershowModel> ordershowModel;
  final color;
  const OrderWidget(
      {Key? key,
      required this.ordershowModel,
      required this.color,
      required this.width})
      : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  OrderShowController orderShowController = Get.put(OrderShowController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        widget.ordershowModel.length.toInt() != 0 ||
                widget.ordershowModel.isNotEmpty
            ? GetBuilder<OrderShowController>(
                init: OrderShowController(),
                builder: (knm) => Obx(() {
                      if (knm.isLoading.value) {
                        return Center(
                          child: Container(),
                        );
                      } else {
                        return Column(
                            children: List.generate(
                                widget.ordershowModel.length,
                                (index) => Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailOrder(
                                                          idrecipient: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .recipientId
                                                              .toString(),
                                                          idsender:  widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .senderId
                                                              .toString(),
                                                          idorder: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                              idinvoid: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!.invoiceId
                                                              .toString(),
                                                          tonthang: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .originalBranch
                                                              .toString(),
                                                          piythang: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .destinationBranch
                                                              .toString(),
                                                          orderItem: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .orderItem!
                                                              .toList(),
                                                          idcategories: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .orderItem![0]
                                                              .attribute!
                                                              .categoryId
                                                              .toString(),
                                                          status: widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .status
                                                              .toString(),
                                                        )));
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              width: widget.width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade100),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 65,
                                                      child: Image.asset(
                                                          'images/box.png')),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, top: 15),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(widget
                                                              .ordershowModel[
                                                                  index]
                                                              .attributes!
                                                              .invoiceId
                                                              .toString()),
                                                          Text('name: ' +
                                                              widget
                                                                  .ordershowModel[
                                                                      index]
                                                                  .attributes!
                                                                  .orderItem![0]
                                                                  .attribute!
                                                                  .parcelName
                                                                  .toString()),
                                                        ]),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 30,
                                                child: Text(
                                                  widget.ordershowModel[index]
                                                      .attributes!.status
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: widget.ordershowModel[index]
                                                      .attributes!.status
                                                      .toString() == 'Picked' ? Colors.green : Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        widget.ordershowModel[index].attributes!
                                                    .status
                                                    .toString() ==
                                                'Pending'
                                            ? Positioned(
                                                top: 55,
                                                right: 10,
                                                child: Container(
                                                  width: 100,
                                                  height: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.red,
                                                              elevation: 0),
                                                      child: Text(
                                                        'ຍົກເລີກ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        showCupertinoDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                dialog(widget
                                                                    .ordershowModel[
                                                                        index]
                                                                    .id
                                                                    .toString()));
                                                      },
                                                    ),
                                                  ),
                                                ))
                                            : Container()
                                      ],
                                    )));
                      }
                    }))
            : Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.asset('images/logo.jpeg')),
                  ),
                  SizedBox(height: 10),
                  Text('ບໍ່ມີຂໍ້ມູນ',
                      style: TextStyle(
                          fontFamily: 'nsl_bold',
                          color: Colors.black,
                          fontSize: 18)),
                          SizedBox(height: 20),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        orderShowController.onInit();
                      },
                      icon: Icon(
                        Icons.refresh_outlined,
                        size: 45,
                        color: Colors.blue,
                      ))
                ],
              ),
      ],
    );
  }

  Future<http.Response> deleteData(String id) async {
    showDialog(context: context, builder: (context) => dialog3());
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
      Navigator.pop(context);
    } else {}
    return response;
  }

  Widget dialog3() => const CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text('ກະລຸນາລໍຖ້າ')),
        ),
      );
  Widget dialog(String id) => CupertinoAlertDialog(
        title: Text(''),
        content: Text('ທ່ານຕ້ອງການຍົກເລີກລາຍການນີ້ຫຼືບໍ່?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
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
