import 'package:get/get.dart';

import '../models/category.dart';
import '../services/apis/category_api.dart';

class CategoryController extends GetxController {
  final _categoryApi = CategoryApi();
  final categories = <Category>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  // fetch category
  Future<void> fetchCategory() async {
    isLoading(true);
    final categoryList = await _categoryApi.fetchCategory();
    categories.assignAll(categoryList);
    isLoading(false);
  }
}
