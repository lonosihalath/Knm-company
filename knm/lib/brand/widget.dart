import 'package:get/get.dart';
import 'package:knm/brand/brand_controller.dart';

BranchController branchController = Get.put(BranchController());

List<String> sakha = List.generate(branchController.statetList.length,
    (index) => branchController.statetList[index].name.toString());