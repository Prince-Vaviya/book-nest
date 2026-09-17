import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../../widgets/book_card.dart';
import '../../widgets/streak_badge.dart';
import '../details/book_detail_screen.dart';
import '../reader/reader_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigateTab;

  const HomeScreen({super.key, required this.onNavigateTab});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final priorityBook = library.priorityBook;
    final goal = library.goal;

    return Scaffold(
      backgroundColor: AppColors.canvasPaper,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
          children: [
            // Top Bar Greeting & Streak
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getGreeting()}, ${library.userName} 👋',
                      style: AppTypography.displayMedium(color: AppColors.secondaryIndigo)
                          .copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Your intellectual sanctuary is ready',
                      style: AppTypography.bodySmall(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                StreakBadge(streakDays: goal.currentStreakDays, isCompact: true),
              ],
            ),
            const SizedBox(height: 20),

            // Daily Reading Goal Progress Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryIndigo.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Circular Progress Indicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 58,
                        height: 58,
                        child: CircularProgressIndicator(
                          value: goal.dailyProgressPercentage,
                          strokeWidth: 6,
                          backgroundColor: AppColors.surfaceContainerLow,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryAmber,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Text(
                        '${(goal.dailyProgressPercentage * 100).toInt()}%',
                        style: AppTypography.labelSmall(color: AppColors.primaryAmber)
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today’s Goal',
                          style: AppTypography.labelLarge(color: AppColors.secondaryIndigo),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${goal.minutesReadToday} of ${goal.dailyTargetMinutes} mins completed',
                          style: AppTypography.bodySmall(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (priorityBook != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReaderScreen(book: priorityBook),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAmber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: const Text('READ'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Continue Reading Priority Hero Card
            if (priorityBook != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue Reading',
                    style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
                  ),
                  TextButton(
                    onPressed: () => onNavigateTab(2), // Jump to Library tab
                    child: Text(
                      'View All',
                      style: AppTypography.labelMedium(color: AppColors.primaryAmber),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BookCard(
                book: priorityBook,
                displayMode: BookCardDisplayMode.hero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(bookId: priorityBook.id),
                    ),
                  );
                },
                onResumeReading: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReaderScreen(book: priorityBook),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
            ],

            // Curated Collections Carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Curated For You',
                  style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
                ),
                TextButton(
                  onPressed: () => onNavigateTab(1), // Jump to Explore
                  child: Text(
                    'Explore',
                    style: AppTypography.labelMedium(color: AppColors.primaryAmber),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 275,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: library.allBooks.length,
                separatorBuilder: (context, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final book = library.allBooks[index];
                  return BookCard(
                    book: book,
                    displayMode: BookCardDisplayMode.grid,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailScreen(bookId: book.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 28),

            // Trending in Philosophy & Technology
            Text(
              'Trending in System Design & Wisdom',
              style: AppTypography.headlineSmall(color: AppColors.secondaryIndigo),
            ),
            const SizedBox(height: 12),
            ...library.allBooks.take(3).map((book) {
              return BookCard(
                book: book,
                displayMode: BookCardDisplayMode.list,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(bookId: book.id),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
