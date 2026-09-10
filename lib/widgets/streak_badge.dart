import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

class StreakBadge extends StatelessWidget {
  final int streakDays;
  final bool isCompact;

  const StreakBadge({
    super.key,
    required this.streakDays,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFFFEDD5), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🔥',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 4),
            Text(
              '$streakDays d',
              style: AppTypography.labelMedium(color: AppColors.streakFlame)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: const Color(0xFFFFEDD5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.streakFlame.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🔥',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 6),
          Text(
            '$streakDays Day Streak',
            style: AppTypography.labelLarge(color: AppColors.streakFlame)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
