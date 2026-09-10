import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../providers/library_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';

class BarcodeScannerModal extends StatefulWidget {
  const BarcodeScannerModal({super.key});

  @override
  State<BarcodeScannerModal> createState() => _BarcodeScannerModalState();
}

class _BarcodeScannerModalState extends State<BarcodeScannerModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _laserController;
  bool _isScanned = false;
  Book? _detectedBook;

  @override
  void initState() {
    super.initState();
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Simulate successful ISBN barcode scan after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        final library = context.read<LibraryProvider>();
        setState(() {
          _isScanned = true;
          _detectedBook = library.allBooks.first;
        });
      }
    });
  }

  @override
  void dispose() {
    _laserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.secondaryIndigo,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Scan ISBN Barcode',
                  style: AppTypography.headlineSmall(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Point camera at the back cover of a physical book',
            style: AppTypography.bodySmall(color: Colors.white70),
          ),
          const SizedBox(height: 24),

          // Camera Viewport Simulation
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background viewfinder icon
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 140,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isScanned ? 'ISBN Found!' : 'Searching for barcode...',
                        style: AppTypography.labelMedium(
                          color: _isScanned ? AppColors.primaryAmber : Colors.white60,
                        ),
                      ),
                    ],
                  ),

                  // Scanning Laser
                  if (!_isScanned)
                    AnimatedBuilder(
                      animation: _laserController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(0, (_laserController.value * 2) - 1),
                          child: Container(
                            height: 2,
                            width: 200,
                            decoration: BoxDecoration(
                              color: AppColors.primaryAmber,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryAmber.withValues(alpha: 0.8),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  // Viewfinder Frame Corners
                  Positioned(
                    top: 30,
                    left: 30,
                    child: _buildCorner(isTop: true, isLeft: true),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: _buildCorner(isTop: true, isLeft: false),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: _buildCorner(isTop: false, isLeft: true),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: _buildCorner(isTop: false, isLeft: false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Scan Result Card
          if (_isScanned && _detectedBook != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _detectedBook!.coverUrl,
                      width: 45,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _detectedBook!.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelLarge(color: AppColors.secondaryIndigo),
                        ),
                        Text(
                          _detectedBook!.author,
                          style: AppTypography.labelSmall(color: AppColors.textMuted),
                        ),
                        Text(
                          'ISBN: ${_detectedBook!.isbn}',
                          style: AppTypography.labelSmall(color: AppColors.primaryAmber),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added "${_detectedBook!.title}" to your Nest!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAmber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                    child: const Text('ADD'),
                  ),
                ],
              ),
            )
          else
            const SizedBox(height: 80),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppColors.primaryAmber, width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppColors.primaryAmber, width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppColors.primaryAmber, width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppColors.primaryAmber, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}
