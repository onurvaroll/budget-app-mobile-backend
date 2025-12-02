import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/extensions/extensions.dart';
import 'package:gelir_gider/modules/transaction/controller/category_controller.dart';
import 'package:gelir_gider/app/utils/icon_helper.dart';
import 'package:get/get.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return AlertDialog(
      title: const Text('Kategori Ekle'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Kategori Adı',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category_outlined),
              ),
              onChanged: (value) => controller.categoryName.value = value,
              validator: (value) => value == null || value.isEmpty
                  ? 'Kategori adı boş olamaz'
                  : null,
            ),
            2.yh,
            Obx(
              () => DropdownButtonFormField<String>(
                items: icons
                    .map(
                      (type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                value: controller.selectedIcon.value.isEmpty
                    ? null
                    : controller.selectedIcon.value,
                decoration: const InputDecoration(
                  hintText: 'Kategori İconu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.emoji_objects_outlined),
                ),

                onChanged: (value) {
                  if (value != null) {
                    controller.selectedIcon.value = value;
                  }
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Kategori türü seçilmelidir'
                    : null,
              ),
            ),
            4.yh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('İptal'),
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      controller.isLoading.value
                          ? null
                          : controller.createCategory();
                      Get.back();
                    },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator()
                        : const Text('Ekle'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
