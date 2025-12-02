import 'package:flutter/material.dart';
import 'package:gelir_gider/app/routes/app_routes.dart';
import 'package:gelir_gider/modules/settings/controller/settings_controller.dart';
import 'package:gelir_gider/modules/settings/widgets/settings_card.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<SettingsController>(SettingsController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ayarlar',
              style: context.theme.textTheme.headlineLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),

            // Tema Ayarı
            SettingsCard(),
            const SizedBox(height: 12),

            // Kategori Yönetimi
            Card(
              child: ListTile(
                leading: const Icon(Icons.category_outlined),
                title: const Text('Kategorileri Yönet'),
                subtitle: const Text('Özel kategorilerinizi düzenleyin'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Get.toNamed(AppRoutes.categoryManagement),
              ),
            ),

            const Spacer(),

            // Çıkış Butonu
            ElevatedButton.icon(
              onPressed: () async => await controller.signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
