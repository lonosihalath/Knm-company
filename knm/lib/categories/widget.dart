import 'package:get/get.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/categories/comtroller.dart';

CategoriesController categoriesController = Get.put(CategoriesController());

List<String> categories = List.generate(categoriesController.statetList.length,
    (index) => categoriesController.statetList[index].name.toString());