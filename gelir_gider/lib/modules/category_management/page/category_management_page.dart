import 'package:flutter/material.dart';
import 'package:gelir_gider/app/constants/app_paddings.dart';
import 'package:gelir_gider/app/constants/app_radius.dart';
import 'package:gelir_gider/app/themes/app_colors.dart';
import 'package:gelir_gider/app/utils/icon_helper.dart';
import 'package:gelir_gider/modules/category_management/controller/category_management_controller.dart';
import 'package:get/get.dart';

class CategoryManagementPage extends GetView<CategoryManagementController> {
  const CategoryManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategorileri Yönet'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCategoryDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Yeni Kategori'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userCategories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 80,
                  color: isDark ? AppColors.darkTextHint : AppColors.textHint,
                ),
                const SizedBox(height: 16),
                Text(
                  'Henüz özel kategori eklemediniz',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark ? AppColors.darkTextHint : AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Yeni kategori eklemek için + butonuna tıklayın',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.darkTextHint : AppColors.textHint,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: AppPaddings.allMd,
          itemCount: controller.userCategories.length,
          itemBuilder: (context, index) {
            final category = controller.userCategories[index];
            final isIncome = category.type == 'income';
            final categoryColor = isIncome
                ? (isDark ? AppColors.darkIncome : AppColors.income)
                : (isDark ? AppColors.darkExpense : AppColors.expense);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
              child: ListTile(
                contentPadding: AppPaddings.hMd,
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.15),
                    borderRadius: AppRadius.allMd,
                  ),
                  child: Icon(
                    getCategoryIcon(
                      iconName: category.icon ?? 'wallet',
                      isSystem: false,
                      type: category.type ?? 'expense',
                    ),
                    color: categoryColor,
                  ),
                ),
                title: Text(
                  category.name ?? 'Bilinmeyen',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  isIncome ? 'Gelir' : 'Gider',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: categoryColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                      onPressed: () {
                        controller.startEditing(category);
                        _showCategoryDialog(context, isEditing: true);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: isDark
                            ? AppColors.darkExpense
                            : AppColors.expense,
                      ),
                      onPressed: () =>
                          controller.showDeleteConfirmation(category),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showCategoryDialog(BuildContext context, {bool isEditing = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isEditing) {
      controller.clearForm();
    }

    Get.bottomSheet(
      Container(
        padding: AppPaddings.allLg,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCardBackground
              : AppColors.cardBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkDivider : AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isEditing ? 'Kategori Düzenle' : 'Yeni Kategori',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),

              // Kategori Adı
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Kategori Adı',
                  hintText: 'Örn: Eğlence',
                  prefixIcon: const Icon(Icons.label_outline),
                  border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                ),
              ),
              const SizedBox(height: 20),

              // Kategori Tipi
              Text(
                'Kategori Tipi',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildTypeChip(
                        context,
                        'Gider',
                        'expense',
                        Icons.trending_down,
                        isDark ? AppColors.darkExpense : AppColors.expense,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTypeChip(
                        context,
                        'Gelir',
                        'income',
                        Icons.trending_up,
                        isDark ? AppColors.darkIncome : AppColors.income,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // İkon Seçimi
              Text('İkon Seç', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: icons.map((iconName) {
                    final isSelected =
                        controller.selectedIcon.value == iconName;
                    return GestureDetector(
                      onTap: () => controller.selectedIcon.value = iconName,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2)
                              : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.surface),
                          borderRadius: AppRadius.allMd,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          getCategoryIcon(
                            iconName: iconName,
                            isSystem: false,
                            type: 'expense',
                          ),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Kaydet Butonu
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (isEditing) {
                              controller.updateCategory();
                            } else {
                              controller.createCategory();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.allMd,
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEditing ? 'Güncelle' : 'Kaydet'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final isSelected = controller.selectedType.value == value;

    return GestureDetector(
      onTap: () => controller.selectedType.value = value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: AppRadius.allMd,
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
