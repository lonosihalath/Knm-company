import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/categories/model.dart';
import 'package:knm/screen/order/controller_orderitem.dart';
import 'package:knm/screen/order/show_order_model.dart';

class OrderItemDetail extends StatefulWidget {
  const OrderItemDetail({Key? key}) : super(key: key);

  @override
  State<OrderItemDetail> createState() => _OrderItemDetailState();
}

class _OrderItemDetailState extends State<OrderItemDetail> {
  var orderItems = Get.put(OrderItemController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍລະອຽດ'),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<OrderItemController>(
                init: OrderItemController(),
                builder: (cont) => Column(
                  children: <Widget>[
                    Expanded(
                child: orderItems.items.isNotEmpty ? ListView.builder(
                                  itemCount: orderItems.items.length,
                                  itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.all(10),
                                    width: screen,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                 Container(
                                                      width: 65,
                                                      child: Image.asset(
                                                          'images/box.png')),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('ຊື່ສິນຄ້າ: ' + orderItems.items.values.toList()[index].parcelname.toString(),style: TextStyle(fontSize: 12, fontFamily: 'nsl_regular')),
                                                    datacategory(categoriesController.statetList.where((p0) => p0.id.toString() ==  orderItems.items.values.toList()[index].categoryId.toString()).toList(), 'ປະເພດສິນຄ້າ: '),
                                                    Text('ກ້ວາງ + ຍາວ + ສູງ: ' + orderItems.items.values.toList()[index].widthheight.toString(),style: TextStyle(fontSize: 12, fontFamily: 'nsl_regular')),
                                                    Text('ນໍ້າໜັກ: ' + orderItems.items.values.toList()[index].weight.toString(),style: TextStyle(fontSize: 12, fontFamily: 'nsl_regular')),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(onPressed: (){
                                          orderItems.removeitem(orderItems.items.keys.toList()[index]);
                                        }, icon: Icon(Icons.delete_sweep_sharp,size: 35,color: Colors.red,)),
                                      ],
                                    ),
                                  )) : Center(child: Text('Empty'),),
              ),
                  ])),
      )
    );
  }
      Text datacategory(List<Categories> categories, text) {
    return Text(text + categories[0].name,
        style: TextStyle(fontSize: 12, fontFamily: 'nsl_regular'));
  }
}
