import 'package:gelir_gider/app/constants/api_constants.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/app/service/api_service.dart';
import 'package:get/get.dart';

class CategoryRepositories extends GetxService {
  late final ApiService _apiService;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppCategory>> getCategories() async {
    final response = await _apiService.get(ApiConstants.categories);
    if (response.statusCode == 200) {
      final List data = response.data as List;
      return data.map((e) => AppCategory.fromJson(e)).toList();
    }
    throw Exception('Kategoriler getirilirken hata oluştu');
  }

  Future<AppCategory> createCategory(AppCategory category) async {
    final response = await _apiService.post(
      ApiConstants.categories,
      category.toJson(),
    );
    if (response.statusCode == 201) {
      return AppCategory.fromJson(response.data);
    }
    throw Exception('Kategori oluşturulurken hata oluştu');
  }

  Future<AppCategory> updateCategory(AppCategory category) async {
    final response = await _apiService.put(
      '${ApiConstants.categories}/${category.id}',
      category.toJson(),
    );
    if (response.statusCode == 200) {
      return AppCategory.fromJson(response.data);
    }
    throw Exception('Kategori güncellenirken hata oluştu');
  }

  Future<void> deleteCategory(String id) async {
    final response = await _apiService.delete('${ApiConstants.categories}/$id');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Kategori silinirken hata oluştu');
    }
  }
}
