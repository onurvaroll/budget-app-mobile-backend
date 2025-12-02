import 'package:flutter/material.dart';
import 'package:gelir_gider/app/constants/app_paddings.dart';
import 'package:gelir_gider/app/core/extensions/extensions.dart';
import 'package:gelir_gider/modules/dashboard/widgets/summary_card.dart';
import 'package:gelir_gider/modules/dashboard/widgets/transaction_list.dart';
import 'package:gelir_gider/app/themes/app_colors.dart';
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Summary Cards
                  SizedBox(
                    height: 18.h,
                    child: Obx(
                      () => ListView(
                        scrollDirection: Axis.horizontal,
                        padding: AppPaddings.hSm,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SummaryCard(
                            title: "Aylık Gelir",
                            amount: controller.monthlyIncome.value,
                            icon: Icons.trending_up_rounded,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkIncome
                                : AppColors.income,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkIncomeGradient
                                : AppColors.incomeGradient,
                          ),
                          SummaryCard(
                            title: "Aylık Gider",
                            amount: controller.monthlyExpense.value,
                            icon: Icons.trending_down_rounded,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkExpense
                                : AppColors.expense,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkExpenseGradient
                                : AppColors.expenseGradient,
                          ),
                          SummaryCard(
                            title: "Aylık Bakiye",
                            amount:
                                (controller.monthlyIncome.value -
                                controller.monthlyExpense.value),
                            icon: Icons.account_balance_wallet_rounded,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBalance
                                : AppColors.balance,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBalanceGradient
                                : AppColors.balanceGradient,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Transaction List
                  const Expanded(child: TransactionList()),
                ],
              ),
      ),
    );
  }
}
