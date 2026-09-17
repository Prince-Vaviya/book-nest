import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../admin/admin_shell.dart';
import '../main_shell.dart';
import '../onboarding/onboarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: 'reader@booknest.app');
  final TextEditingController _passwordController =
      TextEditingController(text: 'sanctuary2026');
  bool _obscurePassword = true;
  bool _rememberMe = true;
  int _selectedRoleIndex = 0; // 0: Reader, 1: Administrator

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginAsReader() {
    final library = context.read<LibraryProvider>();
    final enteredName = _usernameController.text.trim();
    library.loginAsReader(name: enteredName.isNotEmpty ? enteredName : 'Reader');

    final destination = library.isOnboardingCompleted
        ? const MainShell()
        : const OnboardingScreen();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _loginAsAdmin() {
    final library = context.read<LibraryProvider>();
    library.loginAsAdmin();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AdminShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasPaper,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Logo & Header
                Center(
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryIndigo,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryIndigo.withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Book',
                      style: AppTypography.displayLarge(color: AppColors.secondaryIndigo)
                          .copyWith(fontSize: 28),
                    ),
                    Text(
                      'Nest',
                      style: AppTypography.displayLarge(color: AppColors.primaryAmber)
                          .copyWith(fontSize: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Sign in to your intellectual sanctuary',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),

                // Role Selector Segment
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedRoleIndex = 0),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedRoleIndex == 0
                                  ? AppColors.secondaryIndigo
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_rounded,
                                  size: 16,
                                  color: _selectedRoleIndex == 0
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Reader Login',
                                  style: AppTypography.labelMedium(
                                    color: _selectedRoleIndex == 0
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ).copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedRoleIndex = 1),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedRoleIndex == 1
                                  ? AppColors.secondaryIndigo
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.admin_panel_settings_rounded,
                                  size: 16,
                                  color: _selectedRoleIndex == 1
                                      ? AppColors.primaryLightAmber
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Admin Login',
                                  style: AppTypography.labelMedium(
                                    color: _selectedRoleIndex == 1
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ).copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Main Login Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryIndigo.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _selectedRoleIndex == 0
                      ? _buildReaderLoginForm()
                      : _buildAdminLoginForm(),
                ),

                const SizedBox(height: 20),

                // Dedicated Quick One-Click Admin Access Banner / Button
                if (_selectedRoleIndex == 0) ...[
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryIndigo,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryIndigo.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.primaryLightAmber,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Administrator Portal',
                                style: AppTypography.labelLarge(color: Colors.white)
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Instant 1-click access (no password)',
                                style: AppTypography.labelSmall(
                                  color: AppColors.primaryLightAmber,
                                ).copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _loginAsAdmin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAmber,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'ADMIN LOGIN',
                            style: AppTypography.labelSmall(color: Colors.white)
                                .copyWith(fontWeight: FontWeight.w800, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Footer Info
                Center(
                  child: Text(
                    'BookNest Archival Edition • Fast 1-Click Access',
                    style: AppTypography.labelSmall(color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReaderLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR NAME / USERNAME',
          style: AppTypography.labelSmall(color: AppColors.secondaryIndigo)
              .copyWith(letterSpacing: 0.8, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'e.g. Elena, Alex, Marcus',
            prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primaryAmber),
            filled: true,
            fillColor: AppColors.canvasPaper,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'READER EMAIL',
          style: AppTypography.labelSmall(color: AppColors.secondaryIndigo)
              .copyWith(letterSpacing: 0.8, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'reader@booknest.app',
            prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryAmber),
            filled: true,
            fillColor: AppColors.canvasPaper,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'PASSWORD',
          style: AppTypography.labelSmall(color: AppColors.secondaryIndigo)
              .copyWith(letterSpacing: 0.8, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: '••••••••',
            prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primaryAmber),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            filled: true,
            fillColor: AppColors.canvasPaper,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: AppColors.primaryAmber,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (val) => setState(() => _rememberMe = val ?? true),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Remember me',
                  style: AppTypography.bodySmall(color: AppColors.textSecondary),
                ),
              ],
            ),
            Text(
              'Forgot password?',
              style: AppTypography.bodySmall(color: AppColors.primaryAmber)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _loginAsReader,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAmber,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(
              'SIGN IN AS READER',
              style: AppTypography.labelLarge(color: Colors.white)
                  .copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.8),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _loginAsReader,
            icon: const Icon(Icons.auto_stories_rounded, size: 18, color: AppColors.secondaryIndigo),
            label: Text(
              'Quick Guest / Demo Sanctuary',
              style: AppTypography.labelMedium(color: AppColors.secondaryIndigo)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: AppColors.borderLight),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryLightAmber.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryAmber.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.verified_user_rounded, color: AppColors.primaryDarkAmber, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'One-Click Administrator Mode. No credentials needed for curatorial operations.',
                  style: AppTypography.bodySmall(color: AppColors.secondaryIndigo)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: AppColors.secondaryIndigo,
            child: const Icon(Icons.shield_rounded, color: AppColors.primaryLightAmber),
          ),
          title: Text(
            'Chief Archival Curator (Admin)',
            style: AppTypography.labelLarge(color: AppColors.secondaryIndigo)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            'Full inventory, moderation & user access',
            style: AppTypography.bodySmall(color: AppColors.textMuted),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _loginAsAdmin,
            icon: const Icon(Icons.lock_open_rounded, size: 20),
            label: Text(
              'ONE-CLICK ADMIN LOGIN',
              style: AppTypography.labelLarge(color: Colors.white)
                  .copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.8),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryIndigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
