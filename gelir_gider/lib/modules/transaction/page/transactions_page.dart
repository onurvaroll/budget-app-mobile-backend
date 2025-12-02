import 'package:flutter/material.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/modules/transaction/widgets/add_category_dialog.dart';
import 'package:gelir_gider/modules/transaction/widgets/amount_input.dart';
import 'package:gelir_gider/modules/transaction/widgets/category_dropdown.dart';
import 'package:gelir_gider/modules/transaction/widgets/date_input.dart';
import 'package:gelir_gider/modules/transaction/widgets/description_input.dart';
import 'package:gelir_gider/modules/transaction/widgets/save_button.dart';
import 'package:gelir_gider/modules/transaction/widgets/transactions_type_selector.dart';
import 'package:get/get.dart';
import '../controller/transactions_controller.dart';

class TransactionsPage extends GetView<TransactionsController> {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İşlemler')),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TransactionsTypeSelector(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: CategoryDropdown()),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () async {
                                final result = await Get.dialog<AppCategory>(
                                  AddCategoryDialog(),
                                );
                                if (result != null || result == true) {
                                  controller.loadCategories();
                                  controller.selectedCategoryId.value =
                                      result!.id!;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        AmountInput(),
                        SizedBox(height: 16),
                        DescriptionInput(),
                        SizedBox(height: 16),
                        DateInput(),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
