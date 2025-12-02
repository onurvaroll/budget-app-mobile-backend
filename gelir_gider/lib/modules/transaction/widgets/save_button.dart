import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:get/get.dart';

class SaveButton extends GetView<TransactionsController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (controller.formKey.currentState!.validate()) {
          controller.addTransaction();
        }
      },
      icon: const Icon(Icons.save_rounded),
      label: const Text('Kaydet'),
    );
  }
}
