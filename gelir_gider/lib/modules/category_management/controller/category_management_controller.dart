import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/app_category.dart';
import 'package:gelir_gider/app/repositories/category_repositories.dart';
import 'package:get/get.dart';

class CategoryManagementController extends BaseController {
  late final CategoryRepositories _categoryRepositories;

  final categories = <AppCategory>[].obs;
  final userCategories = <AppCategory>[].obs;

  // Form controllers
  final nameController = TextEditingController();
  final selectedType = 'expense'.obs;
  final selectedIcon = 'wallet'.obs;

  final isEditing = false.obs;
  final editingCategoryId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _categoryRepositories = Get.find<CategoryRepositories>();
    loadCategories();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    try {
      setLoading(true);
      final result = await _categoryRepositories.getCategories();
      categories.value = result;
      // Sadece kullanıcının eklediği kategorileri filtrele (is_system = false)
      userCategories.value = result.where((c) => c.isSystem == false).toList();
    } catch (e) {
      showErrorSnackbar(message: 'Kategoriler yüklenirken hata: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> createCategory() async {
    if (nameController.text.trim().isEmpty) {
      showErrorSnackbar(message: 'Kategori adı boş olamaz');
      return;
    }

    try {
      setLoading(true);
      final newCategory = AppCategory(
        name: nameController.text.trim(),
        type: selectedType.value,
        icon: selectedIcon.value,
        isSystem: false,
      );

      await _categoryRepositories.createCategory(newCategory);
      showSuccessSnackbar(message: 'Kategori başarıyla oluşturuldu');
      clearForm();
      await loadCategories();
      Get.back();
    } catch (e) {
      showErrorSnackbar(message: 'Kategori oluşturulurken hata: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateCategory() async {
    if (nameController.text.trim().isEmpty) {
      showErrorSnackbar(message: 'Kategori adı boş olamaz');
      return;
    }

    if (editingCategoryId.value == null) return;

    try {
      setLoading(true);
      final updatedCategory = AppCategory(
        id: editingCategoryId.value,
        name: nameController.text.trim(),
        type: selectedType.value,
        icon: selectedIcon.value,
        isSystem: false,
      );

      await _categoryRepositories.updateCategory(updatedCategory);
      showSuccessSnackbar(message: 'Kategori başarıyla güncellendi');
      clearForm();
      await loadCategories();
      Get.back();
    } catch (e) {
      showErrorSnackbar(message: 'Kategori güncellenirken hata: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      setLoading(true);
      await _categoryRepositories.deleteCategory(id);
      showSuccessSnackbar(message: 'Kategori başarıyla silindi');
      await loadCategories();
    } catch (e) {
      showErrorSnackbar(message: 'Kategori silinirken hata: $e');
    } finally {
      setLoading(false);
    }
  }

  void startEditing(AppCategory category) {
    isEditing.value = true;
    editingCategoryId.value = category.id;
    nameController.text = category.name ?? '';
    selectedType.value = category.type ?? 'expense';
    selectedIcon.value = category.icon ?? 'wallet';
  }

  void clearForm() {
    isEditing.value = false;
    editingCategoryId.value = null;
    nameController.clear();
    selectedType.value = 'expense';
    selectedIcon.value = 'wallet';
  }

  void showDeleteConfirmation(AppCategory category) {
    Get.defaultDialog(
      title: 'Kategoriyi Sil',
      middleText:
          '"${category.name}" kategorisini silmek istediğinize emin misiniz?',
      textConfirm: 'Sil',
      textCancel: 'İptal',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        if (category.id != null) {
          deleteCategory(category.id!);
        }
      },
    );
  }
}
