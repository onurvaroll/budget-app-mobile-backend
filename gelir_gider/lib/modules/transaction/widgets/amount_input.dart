import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:get/state_manager.dart';

class AmountInput extends GetView<TransactionsController> {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Tutar',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen bir tutar girin';
        }
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) {
          return 'Geçerli bir tutar girin';
        }
        return null;
      },
      onChanged: (value) {
        controller.amount.value =
            double.tryParse(value) ?? controller.amount.value;
      },
    );
  }
}
