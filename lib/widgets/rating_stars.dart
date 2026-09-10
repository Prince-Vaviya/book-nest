import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double iconSize;
  final bool showNumber;

  const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount,
    this.iconSize = 14,
    this.showNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.ratingStar,
          size: iconSize + 2,
        ),
        const SizedBox(width: 4),
        if (showNumber)
          Text(
            rating.toStringAsFixed(1),
            style: AppTypography.labelMedium(color: AppColors.textPrimary)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: AppTypography.labelSmall(color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}
