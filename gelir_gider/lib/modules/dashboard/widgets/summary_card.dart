import 'package:flutter/material.dart';
import 'package:gelir_gider/app/constants/app_paddings.dart';
import 'package:gelir_gider/app/constants/app_radius.dart';
import 'package:gelir_gider/app/core/extensions/extensions.dart';
import 'package:gelir_gider/app/utils/amount_helper.dart';
import 'package:get/get.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 42.w,
      height: 16.h,
      margin: AppPaddings.allSm,
      decoration: BoxDecoration(
        gradient: gradientColors.gradientLR,
        borderRadius: AppRadius.cardLarge,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(isDark ? 0.4 : 0.25),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.cardLarge,
        child: Stack(
          children: [
            // Dekoratif arka plan elementi
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.colorScheme.surface.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.colorScheme.surface.withOpacity(0.1),
                ),
              ),
            ),
            // İçerik
            Padding(
              padding: AppPaddings.cardCompact,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Üst kısım - İkon ve başlık
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.25),
                          borderRadius: AppRadius.allSm,
                        ),
                        child: Icon(
                          icon,
                          color: context.theme.colorScheme.onSurface,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          title,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AmountHelper.amountFormatter.format(amount),
                      style: context.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  Text(
                    amount >= 0 ? 'Bu ay' : 'Açık',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
