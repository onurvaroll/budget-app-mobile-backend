import 'package:flutter/material.dart';
import 'package:gelir_gider/app/constants/app_paddings.dart';
import 'package:gelir_gider/app/constants/app_radius.dart';
import 'package:gelir_gider/app/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app/utils/icon_helper.dart' as IconHelper;
import '../controller/dashboard_controller.dart';

class TransactionList extends GetView<DashboardController> {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.myTransactions.isEmpty) {
        return Container(
          margin: AppPaddings.allLg,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkCardBackground
                : AppColors.cardBackground,
            borderRadius: AppRadius.cardLarge,
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : Colors.grey).withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: AppPaddings.allXxl,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: AppPaddings.allXl,
                    decoration: BoxDecoration(
                      color:
                          (isDark
                                  ? AppColors.darkTiffanyBlue
                                  : AppColors.tiffanyBlue)
                              .withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: isDark
                          ? AppColors.darkTiffanyBlue
                          : AppColors.tiffanyBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Henüz işlem yok",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "İlk işleminizi ekleyerek başlayın",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Container(
        margin: AppPaddings.hLg,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCardBackground
              : AppColors.cardBackground,
          borderRadius: AppRadius.cardLarge,
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : Colors.grey).withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: AppRadius.cardLarge,
          child: ListView.separated(
            padding: AppPaddings.vSm,
            itemBuilder: (context, index) {
              var nowTransaction = controller.myTransactions[index];

              // Find category from the loaded list using categoryId
              var category = controller.categories.firstWhereOrNull(
                (c) => c.id == nowTransaction.categoryId,
              );

              // Safe values
              final amount =
                  double.tryParse(nowTransaction.amount ?? '0') ?? 0.0;
              final date = nowTransaction.date ?? DateTime.now();
              final categoryName =
                  category?.name ??
                  nowTransaction.category?.name ??
                  'Kategorisiz';
              final categoryIcon =
                  category?.icon ??
                  nowTransaction.category?.icon ??
                  'help_outline';
              final categoryType =
                  category?.type ?? nowTransaction.category?.type ?? 'expense';

              final isIncome = nowTransaction.type == 'income';
              final transactionColor = isIncome
                  ? (isDark ? AppColors.darkIncome : AppColors.income)
                  : (isDark ? AppColors.darkExpense : AppColors.expense);

              return Dismissible(
                key: ValueKey(nowTransaction.id ?? index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: AppPaddings.hXl,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade300, Colors.red.shade500],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                child: Padding(
                  padding: AppPaddings.listItem,
                  child: Row(
                    children: [
                      // Kategori ikonu
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: transactionColor.withOpacity(0.15),
                          borderRadius: AppRadius.allLg,
                        ),
                        child: Icon(
                          IconHelper.getCategoryIcon(
                            iconName: categoryIcon,
                            isSystem: true,
                            type: categoryType,
                          ),
                          color: transactionColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Başlık ve açıklama
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryName,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              nowTransaction.description?.isNotEmpty == true
                                  ? nowTransaction.description!
                                  : DateFormat(
                                      'dd MMM yyyy',
                                      'tr',
                                    ).format(date),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? AppColors.darkTextHint
                                        : AppColors.textHint,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Tutar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${isIncome ? '+' : '-'}${NumberFormat.currency(symbol: '₺', decimalDigits: 2).format(amount)}',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: transactionColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('HH:mm').format(date),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.darkTextHint
                                      : AppColors.textHint,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  if (nowTransaction.id != null) {
                    controller.deleteTransaction(nowTransaction.id!);
                  }
                },
              );
            },
            itemCount: controller.myTransactions.length,
            separatorBuilder: (context, index) => Padding(
              padding: AppPaddings.hLg,
              child: Divider(
                height: 1,
                color: isDark ? AppColors.darkDivider : AppColors.divider,
              ),
            ),
          ),
        ),
      );
    });
  }
}
