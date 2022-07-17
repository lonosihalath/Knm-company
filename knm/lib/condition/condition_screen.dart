import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:knm/condition/controller.dart';
import 'package:knm/condition/model.dart';

class ConditionScreen extends StatefulWidget {
  const ConditionScreen({Key? key}) : super(key: key);

  @override
  State<ConditionScreen> createState() => _ConditionScreenState();
}

class _ConditionScreenState extends State<ConditionScreen> {
  ConditionController condition = Get.put(ConditionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂ',
          style: TextStyle(fontFamily: 'nsl_bold', fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  if (condition.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                         textMain(condition.statetList.where((p0) => p0.id == 1).toList()),
                         SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              condition.statetList.length-1, (index) => Container(
                                margin: EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(condition.statetList[index+1].note.toString(),
                                      style: TextStyle( fontFamily: condition.statetList[index+1].id!.toInt() == 2
                                      || condition.statetList[index+1].id!.toInt() == 7 
                                      || condition.statetList[index+1].id!.toInt() == 9 
                                      || condition.statetList[index+1].id!.toInt() == 22 
                                      || condition.statetList[index+1].id!.toInt() == 27? 'nsl_bold' : 'nsl_regular',
                                      fontSize: condition.statetList[index+1].id!.toInt() == 2 
                                      || condition.statetList[index+1].id!.toInt() == 7 
                                      || condition.statetList[index+1].id!.toInt() == 9 
                                      || condition.statetList[index+1].id!.toInt() == 22 
                                      || condition.statetList[index+1].id!.toInt() == 27  ? 16 : 15)),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text textMain(List<Condition1> condition1) => Text(condition1[0].note.toString(),style: TextStyle(fontFamily: 'nsl_bold',fontSize: 18),);
}
