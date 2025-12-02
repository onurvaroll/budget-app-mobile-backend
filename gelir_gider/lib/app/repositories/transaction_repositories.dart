import 'package:gelir_gider/app/constants/api_constants.dart';
import 'package:gelir_gider/app/models/app_transaction.dart';
import 'package:gelir_gider/app/models/transaction_params.dart';
import 'package:gelir_gider/app/service/api_service.dart';
import 'package:get/get.dart';

class TransactionRepositories extends GetxService {
  late final ApiService _apiService;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppTransaction>> getTransactions() async {
    final response = await _apiService.get(ApiConstants.transactions);
    if (response.statusCode == 200) {
      final List data = response.data["transactions"] as List;
      return data.map((e) => AppTransaction.fromJson(e)).toList();
    }
    throw Exception('İşlemler getirilirken hata oluştu');
  }

  Future<AppTransaction> createTransaction(Transaction transaction) async {
    final response = await _apiService.post(
      ApiConstants.transactions,
      transaction.toJson(),
    );
    if (response.statusCode == 201) {
      return AppTransaction.fromJson(response.data);
    }
    throw Exception('İşlem oluşturulurken hata oluştu');
  }

  Future<bool> deleteTransaction(String id) async {
    final response = await _apiService.delete(
      '${ApiConstants.transactions}/$id',
    );
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('İşlem silinirken hata oluştu');
  }
}
