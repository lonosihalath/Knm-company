import 'package:get/state_manager.dart';
import 'package:knm/categories/model.dart';
import 'package:knm/categories/services.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var statetList = <Categories>[].obs;

  @override
  void onInit(){
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var categories = await RemoteServiceCategories.fetchCategories();
      if (categories != null) {
        statetList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
}
