import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../providers/library_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../../widgets/book_card.dart';
import '../details/book_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();

    final totalPagesRead = library.allBooks.fold<int>(
      0,
      (sum, b) => sum + b.currentPage,
    );

    return Scaffold(
      backgroundColor: AppColors.canvasPaper,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Library',
                                style: AppTypography.displayMedium(
                                    color: AppColors.secondaryIndigo),
                              ),
                              Text(
                                'Your personal digital bookshelf',
                                style: AppTypography.bodySmall(
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLightAmber,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              '${library.allBooks.length} Titles',
                              style: AppTypography.labelSmall(
                                color: AppColors.primaryDarkAmber,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // High Level Statistics Ribbon
                      Container(
                        padding: const EdgeInsets.all(16),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              '${library.currentlyReading.length}',
                              'In Progress',
                              Icons.auto_stories_rounded,
                              AppColors.primaryAmber,
                            ),
                            _buildVerticalDivider(),
                            _buildStatItem(
                              '${library.completed.length}',
                              'Completed',
                              Icons.check_circle_rounded,
                              AppColors.successGreen,
                            ),
                            _buildVerticalDivider(),
                            _buildStatItem(
                              '$totalPagesRead',
                              'Pages Read',
                              Icons.menu_book_rounded,
                              AppColors.secondaryLightIndigo,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Segmented Tab Bar
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: AppColors.secondaryIndigo,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: AppColors.secondaryIndigo,
                          labelStyle: AppTypography.labelSmall()
                              .copyWith(fontWeight: FontWeight.w700),
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const [
                            Tab(text: 'Reading'),
                            Tab(text: 'To Read'),
                            Tab(text: 'Finished'),
                            Tab(text: 'Favorites'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildBooksTab(library.currentlyReading, 'No books currently in progress'),
              _buildBooksTab(library.wantToRead, 'No books in your reading queue'),
              _buildBooksTab(library.completed, 'No completed books yet'),
              _buildBooksTab(library.favorites, 'No favorite books saved'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTypography.titleMedium(color: AppColors.secondaryIndigo)
              .copyWith(fontWeight: FontWeight.w800),
        ),
        Text(
          label,
          style: AppTypography.labelSmall(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 32,
      width: 1,
      color: AppColors.borderLight,
    );
  }

  Widget _buildBooksTab(List<Book> books, String emptyMessage) {
    if (books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 54,
                color: AppColors.textMuted.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 12),
              Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 80),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
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
      },
    );
  }
}
