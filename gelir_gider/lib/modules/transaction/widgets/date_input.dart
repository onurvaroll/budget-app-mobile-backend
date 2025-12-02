import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:gelir_gider/app/utils/date_helper.dart';
import 'package:get/state_manager.dart';

class DateInput extends GetView<TransactionsController> {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: const Text('Tarih'),
        subtitle: Text(DateHelper.formatDate(controller.date.value.toLocal())),
        trailing: Icon(Icons.calendar_today),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: controller.date.value,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (picked != null) {
            controller.date.value = picked;
          }
          if (picked != null) {
            controller.date.value = picked;
          }
        },
      ),
    );
  }
}
