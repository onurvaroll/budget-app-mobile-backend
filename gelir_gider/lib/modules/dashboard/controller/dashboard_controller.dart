import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/app/models/app_transaction.dart';
import 'package:gelir_gider/app/repositories/category_repositories.dart';
import 'package:gelir_gider/app/repositories/transaction_repositories.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final myTransactions = <AppTransaction>[].obs;
  final categories = <AppCategory>[].obs;
  late final TransactionRepositories _transactionRepositories;
  late final CategoryRepositories _categoryRepositories;

  final monthlyIncome = 0.0.obs;
  final monthlyExpense = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _transactionRepositories = Get.find<TransactionRepositories>();
    _categoryRepositories = Get.find<CategoryRepositories>();
    loadCategories();
    getMyTransactions();
  }

  Future<void> loadCategories() async {
    try {
      final result = await _categoryRepositories.getCategories();
      categories.value = result;
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future getMyTransactions() async {
    try {
      setLoading(true);
      final transactions = await _transactionRepositories.getTransactions();
      debugPrint('Fetched ${transactions.length} transactions');
      myTransactions.value = transactions;
      monthlySummary();
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
    } finally {
      setLoading(false);
    }
  }

  Future deleteTransaction(String id) async {
    try {
      setLoading(true);
      await _transactionRepositories.deleteTransaction(id);
      myTransactions.removeWhere((transaction) => transaction.id == id);
      showSuccessSnackbar(message: 'Transaction deleted successfully');
      monthlySummary();
    } catch (e) {
      showErrorSnackbar(message: 'Error deleting transaction: $e');
      print('Error deleting transaction: $e');
    } finally {
      setLoading(false);
    }
  }

  void refreshDashboard() {
    super.refresh();
    getMyTransactions();
  }

  void monthlySummary() {
    monthlyIncome.value = 0.0;
    monthlyExpense.value = 0.0;
    var now = DateTime.now();
    var nowYear = now.year;
    var nowMonth = now.month;

    debugPrint('Current date: $nowYear-$nowMonth');
    debugPrint('Total transactions: ${myTransactions.length}');

    if (myTransactions.isNotEmpty) {
      // Debug: İlk birkaç transaction'ın tarihlerini göster
      for (var i = 0; i < myTransactions.length && i < 3; i++) {
        var t = myTransactions[i];
        debugPrint(
          'Transaction $i: date=${t.date}, amount=${t.amount}, type=${t.type}',
        );
      }

      var filteredTransactions = myTransactions
          .where(
            (transaction) =>
                transaction.date != null &&
                transaction.date!.year == nowYear &&
                transaction.date!.month == nowMonth,
          )
          .toList();

      debugPrint(
        'Filtered transactions for this month: ${filteredTransactions.length}',
      );

      for (var transaction in filteredTransactions) {
        if (transaction.type == 'income') {
          monthlyIncome.value +=
              double.tryParse(transaction.amount ?? '0') ?? 0.0;
        } else if (transaction.type == 'expense') {
          monthlyExpense.value +=
              double.tryParse(transaction.amount ?? '0') ?? 0.0;
        }
      }
    } else {
      monthlyIncome.value = 0.0;
      monthlyExpense.value = 0.0;
    }
    debugPrint(
      'Monthly Summary - Income: ${monthlyIncome.value}, Expense: ${monthlyExpense.value}',
    );
  }
}
