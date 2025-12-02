import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:get/state_manager.dart';

class DescriptionInput extends GetView<TransactionsController> {
  const DescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Açıklama',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        prefixIcon: Icon(Icons.description_outlined),
      ),
      maxLines: 2,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen bir açıklama girin';
        }
        return null;
      },
      onChanged: (value) {
        controller.description.value = value;
      },
    );
  }
}
