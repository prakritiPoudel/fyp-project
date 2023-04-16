import 'dart:convert';

import 'package:get/get.dart';
import 'package:sporty_waysfluttedo/model/category_model.dart';
import 'package:sporty_waysfluttedo/utils/remote_services.dart';

class HomepageCategoriesController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  List<CategoryModel> categories = <CategoryModel>[];

  loadCategories() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchCategories();
    categories = categoryModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
