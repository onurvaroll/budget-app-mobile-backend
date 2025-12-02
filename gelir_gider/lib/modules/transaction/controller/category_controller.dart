import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:gelir_gider/app/repositories/category_repositories.dart';
import 'package:gelir_gider/app/utils/icon_helper.dart';
import 'package:get/get.dart';

class CategoryController extends BaseController {
  final categoryName = ''.obs;
  final selectedIcon = ''.obs;
  final formKey = GlobalKey<FormState>();
  final categoryType = ''.obs;

  late final CategoryRepositories _categoryRepositories;

  @override
  void onInit() {
    super.onInit();
    _categoryRepositories = Get.find<CategoryRepositories>();
    selectedIcon.value = icons.first;
    categoryType.value =
        Get.find<TransactionsController>().transactionType.value;
  }

  Future<void> createCategory() async {
    try {
      setLoading(true);
      var addedCategory = AppCategory(
        name: categoryName.value,
        icon: selectedIcon.value,
        type: categoryType.value,
      );
      var completeAddCat = await _categoryRepositories.createCategory(
        addedCategory,
      );
      Get.back(result: completeAddCat);
      showSuccessSnackbar(message: 'Category created successfully');
    } catch (e) {
      print('Error creating category: $e');
      showErrorSnackbar(message: 'Error creating category: $e');
    } finally {
      setLoading(false);
    }
  }
}
