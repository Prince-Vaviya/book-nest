import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/app_typography.dart';
import '../books/add_edit_book_modal.dart';

class AdminDashboardScreen extends StatelessWidget {
  final Function(int) onNavigateTab;

  const AdminDashboardScreen({super.key, required this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final admin = context.watch<AdminProvider>();

    return Scaffold(
      backgroundColor: AppColors.canvasPaper,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Operations',
                        style: AppTypography.displayMedium(color: AppColors.secondaryIndigo)
                            .copyWith(fontSize: 22),
                      ),
                      Text(
                        'Platform health and live activity pulse',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'SYSTEM HEALTHY',
                        style: AppTypography.labelSmall(color: AppColors.successGreen)
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // High-Impact KPI Metric Grid
            Row(
              children: [
                Expanded(
                  child: _buildKpiCard(
                    'Active Readers',
                    '12,480',
                    '+14.2% this mo',
                    Icons.people_alt_rounded,
                    AppColors.secondaryIndigo,
                    AppColors.surfaceContainerLow,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKpiCard(
                    'Catalog Titles',
                    '${library.allBooks.length}',
                    '98 drafts pending',
                    Icons.menu_book_rounded,
                    AppColors.primaryAmber,
                    const Color(0xFFFFF7ED),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildKpiCard(
                    'Pending Reviews',
                    '${admin.pendingReviewsCount}',
                    '${admin.flaggedReviewsCount} flagged',
                    Icons.rate_review_rounded,
                    Colors.deepOrange,
                    const Color(0xFFFFF1F2),
                    onTap: () => onNavigateTab(2), // Jump to Reviews tab
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKpiCard(
                    'System Bandwidth',
                    '99.98%',
                    '1.4 GB/hr stream',
                    Icons.cloud_done_rounded,
                    AppColors.successGreen,
                    const Color(0xFFF0FDF4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions Hub
            Text(
              'Quick Actions',
              style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.add_circle_outline_rounded,
                    label: 'Add Title',
                    color: AppColors.primaryAmber,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const AddEditBookModal(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.gavel_rounded,
                    label: 'Moderate Queue',
                    color: AppColors.secondaryIndigo,
                    onTap: () => onNavigateTab(2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.manage_accounts_rounded,
                    label: 'Users Directory',
                    color: AppColors.tertiaryBrown,
                    onTap: () => onNavigateTab(3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Live Platform Activity Feed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Platform Activity',
                  style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Exporting complete audit logs...')),
                    );
                  },
                  child: Text(
                    'Export Logs',
                    style: AppTypography.labelSmall(color: AppColors.primaryAmber),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: admin.activityLogs.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderLight),
                itemBuilder: (context, index) {
                  final log = admin.activityLogs[index];
                  IconData logIcon;
                  Color logColor;

                  switch (log.iconType) {
                    case 'book':
                      logIcon = Icons.library_books_rounded;
                      logColor = AppColors.primaryAmber;
                      break;
                    case 'review':
                      logIcon = Icons.verified_rounded;
                      logColor = AppColors.successGreen;
                      break;
                    default:
                      logIcon = Icons.account_circle_rounded;
                      logColor = AppColors.secondaryIndigo;
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: logColor.withValues(alpha: 0.12),
                      child: Icon(logIcon, size: 18, color: logColor),
                    ),
                    title: Text(
                      log.title,
                      style: AppTypography.labelLarge(color: AppColors.secondaryIndigo),
                    ),
                    subtitle: Text(
                      log.description,
                      style: AppTypography.bodySmall(color: AppColors.textSecondary),
                    ),
                    trailing: Text(
                      log.timestamp,
                      style: AppTypography.labelSmall(color: AppColors.textMuted),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(
    String title,
    String value,
    String subtext,
    IconData icon,
    Color color,
    Color bgColor, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryIndigo.withValues(alpha: 0.03),
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
                  title,
                  style: AppTypography.labelSmall(color: AppColors.textMuted),
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: bgColor,
                  child: Icon(icon, size: 16, color: color),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: AppTypography.displayMedium(color: AppColors.secondaryIndigo)
                  .copyWith(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(
              subtext,
              style: AppTypography.labelSmall(color: color).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.labelSmall(color: AppColors.secondaryIndigo)
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
