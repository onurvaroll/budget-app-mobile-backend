import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gelir_gider/modules/profile/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            final user = controller.user.value;
            return Column(
              children: [
                Text(
                  'Profil Bilgileri',
                  style: context.theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      (user?.profilePhoto != null &&
                          user!.profilePhoto!.isNotEmpty)
                      ? NetworkImage(user.profilePhoto!)
                      : null,
                  child:
                      (user?.profilePhoto == null ||
                          user!.profilePhoto!.isEmpty)
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 16),
                InfoCard(
                  title: 'Adı',
                  value: user == null
                      ? 'Yükleniyor...'
                      : (user.firstName ?? user.name ?? '-'),
                ),
                InfoCard(
                  title: 'Soyadı',
                  value: user == null
                      ? 'Yükleniyor...'
                      : (user.lastName ?? '-'),
                ),
                InfoCard(
                  title: 'E-posta',
                  value: user == null ? 'Yükleniyor...' : (user.email ?? '-'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: context.theme.textTheme.bodyMedium),
        subtitle: Text(
          value,
          style: context.theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
