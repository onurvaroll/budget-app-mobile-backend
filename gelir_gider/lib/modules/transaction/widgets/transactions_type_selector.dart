import 'package:flutter/material.dart';
import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:get/get.dart';

class TransactionsTypeSelector extends GetView<TransactionsController> {
  const TransactionsTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SegmentedButton(
        segments: [
          ButtonSegment(
            value: 'expense',
            label: Text('Gider'),
            icon: Icon(Icons.remove_circle_outline),
          ),
          ButtonSegment(
            value: 'income',
            label: Text('Gelir'),
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
        selected: {controller.transactionType.value},
        onSelectionChanged: (newSelection) {
          controller.transactionType.value = newSelection.first;
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return Colors.transparent;
          }),
        ),
      ),
    );
  }
}
