import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/app/models/transaction_params.dart';
import 'package:gelir_gider/modules/dashboard/controller/dashboard_controller.dart';
import 'package:gelir_gider/app/repositories/category_repositories.dart';
import 'package:gelir_gider/app/repositories/transaction_repositories.dart';
import 'package:get/get.dart';

class TransactionsController extends BaseController {
  final CategoryRepositories _categoryRepositories =
      Get.find<CategoryRepositories>();
  final TransactionRepositories _transactionRepositories =
      Get.find<TransactionRepositories>();

  final categories = <AppCategory>[].obs;
  final selectedCategoryId = "".obs;
  final transactionType = 'expense'.obs;
  final formKey = GlobalKey<FormState>();
  final amount = 0.0.obs;
  final description = ''.obs;
  final date = DateTime.now().obs;

  @override
  void onInit() async {
    super.onInit();
    await loadCategories();
    ever(transactionType, (callback) {
      final filteredCategories = categories
          .where((category) => category.type == transactionType.value)
          .toList();
      if (filteredCategories.isNotEmpty) {
        selectedCategoryId.value = filteredCategories.first.id!;
      } else {
        selectedCategoryId.value = "";
      }
    });
  }

  Future<void> addTransaction() async {
    try {
      setLoading(true);
      if (!formKey.currentState!.validate()) return null;

      print("Selected Category ID: ${selectedCategoryId.value}");

      final newTransaction = Transaction(
        id: '',
        userId: '',
        amount: amount.value,
        description: description.value,
        categoryId: selectedCategoryId.value,
        type: transactionType.value,
        date: date.value,
      );
      await _transactionRepositories.createTransaction(newTransaction);
      print("Transaction created: ${newTransaction.toJson()}");
      Get.find<DashboardController>().refreshDashboard();
      Get.back();
      showSuccessSnackbar(message: 'Transaction added successfully');
      clearForm();
    } catch (e) {
      showErrorSnackbar(message: 'Error adding transaction: $e');
      print(e);
    } finally {
      setLoading(false);
    }
  }

  void clearForm() {
    amount.value = 0.0;
    description.value = '';
    date.value = DateTime.now();
    final filteredCategories = categories
        .where((category) => category.type == transactionType.value)
        .toList();
    if (filteredCategories.isNotEmpty) {
      selectedCategoryId.value = filteredCategories.first.id!;
    } else {
      selectedCategoryId.value = "";
    }
  }

  Future<void> loadCategories() async {
    setLoading(true);
    try {
      final result = await _categoryRepositories.getCategories();
      categories.value = result;
      print(
        "Loaded categories: ${categories.map((e) => '${e.name} (${e.id})').toList()}",
      );
      getFirstCategoryId();
    } catch (e) {
      showErrorSnackbar(message: 'Error loading categories: $e');
    } finally {
      setLoading(false);
    }
  }

  void getFirstCategoryId() {
    final filteredCategories = categories
        .where((category) => category.type == transactionType.value)
        .toList();
    if (filteredCategories.isNotEmpty) {
      selectedCategoryId.value = filteredCategories.first.id!;
    } else {
      selectedCategoryId.value = "";
    }
  }
}
