import 'package:get/get.dart';
import 'package:knm/brand/brand_controller.dart';

BranchController branchController = Get.put(BranchController());

List<String> sakha = List.generate(branchController.statetList.length,
    (index) => branchController.statetList[index].name.toString());



List<String> sakha21 = [branchController.statetList[1].name.toString(),branchController.statetList[2].name.toString()];
List<String> sakha22 = [branchController.statetList[0].name.toString(),branchController.statetList[2].name.toString()];
List<String> sakha23 = [branchController.statetList[0].name.toString(),branchController.statetList[1].name.toString()];
    ///////////////////////////////////////////////////////////////////
