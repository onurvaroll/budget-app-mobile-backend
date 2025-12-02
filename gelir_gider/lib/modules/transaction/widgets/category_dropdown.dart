import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:gelir_gider/app/utils/icon_helper.dart';
import 'package:get/get.dart';

class CategoryDropdown extends GetView<TransactionsController> {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Kategori',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        value: controller.selectedCategoryId.value,
        items: controller.categories
            .where(
              (category) => category.type == controller.transactionType.value,
            )
            .map(
              (category) => DropdownMenuItem(
                value: category.id,
                child: Row(
                  children: [
                    Icon(
                      getCategoryIcon(
                        iconName: category.icon!,
                        isSystem: category.isSystem!,
                        type: category.type!,
                      ),
                    ),
                    Text(category.name!),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          controller.selectedCategoryId.value = value.toString();
        },
      ),
    );
  }
}
