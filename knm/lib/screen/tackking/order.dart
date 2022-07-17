import 'package:flutter/material.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:get/get.dart';
import 'package:knm/screen/tackking/order_Tacking.dart';

class OrderTotacking extends StatefulWidget {
  const OrderTotacking({Key? key}) : super(key: key);

  @override
  State<OrderTotacking> createState() => _OrderTotackingState();
}

class _OrderTotackingState extends State<OrderTotacking> {
  OrderShowController orderShowController = Get.put(OrderShowController());

  @override
  void initState() {
    super.initState();
    orderShowController.onInit();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('ຕິດຕາມເຄື່ອງ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Obx(() {
                  if (orderShowController.isLoading.value)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else {
                    return Column(
                        children: List.generate(
                            orderShowController.statetList.length,
                            (index) => Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (cotext) => Order_Tacking(
                                            orderId: orderShowController.statetList[index].id,
                                            index: index,
                                            status: orderShowController.statetList[index].attributes!.status
                                          )));
                                       
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(bottom: 10),
                                          width: width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.grey.shade100),
                                          child: Row(
                                            children: [
                                              Container(
                                              width: 65,
                                              child: Image.asset('images/box.png')),
                                              Container(
                                                margin: EdgeInsets.only(left: 10,top: 15),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          orderShowController.statetList[index]
                                                              .attributes!.invoiceId
                                                              .toString()),
                                                      Text('ຊື່ພັດສະດຸ: ' +
                                                          orderShowController.statetList[index]
                                                              .attributes!
                                                              .orderItem![0]
                                                              .attribute!
                                                              .parcelName
                                                              .toString(),style: TextStyle(fontFamily: 'nsl_regular'),),
                                                    ]),
                                              ),
                                            ],
                                          )),
                                    ),
                                   
                                  ],
                                )));
                  }
                }),
              // Column(
              //     children: [
              //       Container(
              //         color: Colors.white,
              //         width: 110,
              //         height: 110,
              //         child: ClipRRect(
              //             borderRadius: BorderRadius.circular(55),
              //             child: Image.asset('images/logo.jpeg')),
              //       ),
              //       SizedBox(height: 10),
              //       Text('ບໍ່ມີຂໍ້ມູນ',
              //           style: TextStyle(
              //               fontFamily: 'nsl_bold',
              //               color: Colors.black,
              //               fontSize: 18)),
              //     ],
              //   ),
            )
          ],
        ),
      )
    );
  }
}
