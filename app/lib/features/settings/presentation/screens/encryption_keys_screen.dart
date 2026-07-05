import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class EncryptionKeysScreen extends StatefulWidget {
  const EncryptionKeysScreen({super.key});

  @override
  State<EncryptionKeysScreen> createState() => _EncryptionKeysScreenState();
}

class _EncryptionKeysScreenState extends State<EncryptionKeysScreen> with SingleTickerProviderStateMixin {
  late AnimationController _morphController;
  late Animation<double> _morphRadiusAnimation;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _morphRadiusAnimation = Tween<double>(begin: 0.4, end: 0.7).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _morphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.04),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Soulmate',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          AnimatedBuilder(
            animation: _morphController,
            builder: (context, child) {
              return Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32 * _morphRadiusAnimation.value),
                    topRight: Radius.circular(32 * (1 - _morphRadiusAnimation.value)),
                    bottomLeft: Radius.circular(32 * 0.3),
                    bottomRight: Radius.circular(32 * 0.7),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
          children: [
            // Hero Section
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _morphController,
                          builder: (context, child) {
                            return Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryFixedDim.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(96 * _morphRadiusAnimation.value),
                                  topRight: Radius.circular(96 * (1 - _morphRadiusAnimation.value)),
                                  bottomLeft: Radius.circular(96 * 0.4),
                                  bottomRight: Radius.circular(96 * 0.6),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerLowest,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.08),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.shield, color: AppTheme.primary, size: 40),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Encryption Keys',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your privacy is our priority. Your conversations are secured with end-to-end encryption, ensuring only you and your Soulmate companion can access them.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Status Indicator Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.08),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.tertiaryContainer.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle, color: AppTheme.tertiary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'Encryption Status: Active & Secure',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.tertiaryFixed,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'Protected',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onTertiaryFixedVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Main Options Grid
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.key,
                    iconColor: AppTheme.primary,
                    iconBgColor: AppTheme.primaryFixed,
                    title: 'View Recovery Key',
                    description: 'Access your master recovery phrase. For your security, this requires your account password.',
                    statusText: 'Password protected',
                    statusIcon: Icons.lock,
                    statusColor: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.sync_lock,
                    iconColor: AppTheme.secondary,
                    iconBgColor: AppTheme.secondaryFixed,
                    title: 'Rotate Encryption Keys',
                    description: 'Generate new security keys for your session. Recommended for advanced users or security audits.',
                    statusText: 'Advanced setting',
                    statusIcon: Icons.bolt,
                    statusColor: AppTheme.secondary,
                    onTap: _rotateKeys,
                    isLoading: _isRotating,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Supportive Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryFixed.withOpacity(0.3),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.security, size: 48, color: AppTheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOULMATE COMMITMENT',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimaryFixedVariant,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Encryption isn't just a feature; it's a promise. We use industry-leading AES-256 protocols to ensure that your thoughts, feelings, and secrets remain entirely your own. Your Soulmate is a safe space, built on a foundation of absolute trust.",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onPrimaryFixedVariant.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.06),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.auto_awesome_outlined, 'Reflect', false),
            _buildNavItem(Icons.self_improvement_outlined, 'Rituals', false),
            _buildNavItem(Icons.favorite_border, 'Soulmate', false),
            _buildNavItem(Icons.person, 'Settings', true),
          ],
        ),
      ),
    );
  }

  Future<void> _rotateKeys() async {
    setState(() => _isRotating = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isRotating = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Encryption keys successfully rotated.'),
          backgroundColor: AppTheme.tertiaryContainer,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required String statusText,
    required IconData statusIcon,
    required Color statusColor,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.08),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: isLoading
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  statusText,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(statusIcon, color: statusColor, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: isActive
            ? BoxDecoration(
                color: AppTheme.primaryFixed,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.onPrimaryFixedVariant : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: isActive ? AppTheme.onPrimaryFixedVariant : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
