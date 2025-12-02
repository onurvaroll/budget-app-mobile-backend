import 'package:gelir_gider/modules/transaction/controller/transactions_controller.dart';
import 'package:get/get.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionsController());
  }
}
