import 'package:flutter/material.dart';
import '../admin/admin_shell.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../../widgets/streak_badge.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final goal = library.goal;

    return Scaffold(
      backgroundColor: AppColors.canvasPaper,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
          children: [
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primaryLightAmber,
                  child: Text(
                    'R',
                    style: AppTypography.displayMedium(color: AppColors.primaryDarkAmber),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rajneesh',
                        style: AppTypography.headlineLarge(color: AppColors.secondaryIndigo),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Curator & Software Architect',
                        style: AppTypography.bodySmall(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      StreakBadge(streakDays: goal.currentStreakDays, isCompact: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Reading Analytics & Habits
            Text(
              'Weekly Reading Activity',
              style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryIndigo.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daily Minutes',
                        style: AppTypography.labelLarge(color: AppColors.secondaryIndigo),
                      ),
                      Text(
                        'Avg 43 mins/day',
                        style: AppTypography.labelSmall(color: AppColors.primaryAmber)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Weekly Bar Chart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar('Mon', goal.weeklyMinutesHistory[0], 60),
                      _buildBar('Tue', goal.weeklyMinutesHistory[1], 60),
                      _buildBar('Wed', goal.weeklyMinutesHistory[2], 60),
                      _buildBar('Thu', goal.weeklyMinutesHistory[3], 60),
                      _buildBar('Fri', goal.weeklyMinutesHistory[4], 60),
                      _buildBar('Sat', goal.weeklyMinutesHistory[5], 60),
                      _buildBar('Sun', goal.weeklyMinutesHistory[6], 60, isToday: true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Badges & Milestones
            Text(
              'Reader Achievements',
              style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildBadgeCard(
                    '🔥 14-Day Streak',
                    'Consistency Champion',
                    AppColors.primaryLightAmber,
                    AppColors.streakFlame,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBadgeCard(
                    '📖 500+ Pages',
                    'Deep Thinker',
                    AppColors.secondaryContainer,
                    AppColors.secondaryIndigo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBadgeCard(
                    '🏛️ Polymath',
                    '4 Unique Genres',
                    const Color(0xFFDCFCE7),
                    AppColors.successGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Settings List
            Text(
              'Preferences & Nest Settings',
              style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.admin_panel_settings_rounded,
                    title: 'Admin Operations Portal',
                    subtitle: 'Catalog inventory, moderation & users',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryIndigo,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'ADMIN',
                        style: AppTypography.labelSmall(color: AppColors.primaryLightAmber)
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 10),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminShell(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingsTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Daily Reading Reminders',
                    subtitle: '8:00 PM every evening',
                    trailing: Switch(
                      value: true,
                      activeThumbColor: AppColors.primaryAmber,
                      onChanged: (val) {},
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingsTile(
                    icon: Icons.font_download_outlined,
                    title: 'Default Typography',
                    subtitle: 'Literata (Serif) • 17pt',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingsTile(
                    icon: Icons.cloud_download_outlined,
                    title: 'Export Reading Notes & Highlights',
                    subtitle: 'Markdown & PDF format',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Exporting reading notes to Markdown...')),
                      );
                    },
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About BookNest',
                    subtitle: 'Version 1.0.0 (Archival Edition)',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String day, int minutes, int maxMinutes, {bool isToday = false}) {
    final heightRatio = (minutes / maxMinutes).clamp(0.1, 1.0);
    final barHeight = 80.0 * heightRatio;

    return Column(
      children: [
        Text(
          '${minutes}m',
          style: AppTypography.labelSmall(
            color: isToday ? AppColors.primaryAmber : AppColors.textMuted,
          ).copyWith(fontWeight: isToday ? FontWeight.w700 : FontWeight.w400),
        ),
        const SizedBox(height: 6),
        Container(
          width: 24,
          height: barHeight,
          decoration: BoxDecoration(
            color: isToday ? AppColors.primaryAmber : AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: AppTypography.labelSmall(
            color: isToday ? AppColors.secondaryIndigo : AppColors.textMuted,
          ).copyWith(fontWeight: isToday ? FontWeight.w700 : FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBadgeCard(String title, String subtitle, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.labelSmall(color: iconColor).copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.labelSmall(color: AppColors.textSecondary).copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondaryIndigo),
      title: Text(
        title,
        style: AppTypography.labelLarge(color: AppColors.secondaryIndigo),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(color: AppColors.textMuted),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
