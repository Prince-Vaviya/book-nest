import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReadingProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final Color activeColor;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const ReadingProgressBar({
    super.key,
    required this.progress,
    this.height = 6.0,
    this.activeColor = AppColors.primaryAmber,
    this.backgroundColor = AppColors.surfaceContainerLow,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(height / 2);
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              width: constraints.maxWidth * clampedProgress,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    activeColor,
                    activeColor.withValues(alpha: 0.85),
                  ],
                ),
                borderRadius: radius,
                boxShadow: clampedProgress > 0
                    ? [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
