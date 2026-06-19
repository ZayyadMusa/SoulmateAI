import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PremiumSubscriptionScreen extends StatefulWidget {
  const PremiumSubscriptionScreen({super.key});

  @override
  State<PremiumSubscriptionScreen> createState() => _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _morphController;
  late Animation<double> _morphRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
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
        backgroundColor: AppTheme.surface,
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.04),
        titleSpacing: 24,
        title: Row(
          children: [
            AnimatedBuilder(
              animation: _morphController,
              builder: (context, child) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.primaryContainer, AppTheme.secondaryContainer],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40 * _morphRadiusAnimation.value),
                      topRight: Radius.circular(40 * (1 - _morphRadiusAnimation.value)),
                      bottomLeft: Radius.circular(40 * 0.3),
                      bottomRight: Radius.circular(40 * 0.7),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              'Soulmate',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
          children: [
            // Subscription Hero Section
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryFixed,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppTheme.secondaryContainer.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_awesome, color: AppTheme.onSecondaryFixedVariant, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Soulmate Plus (Active)',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onSecondaryFixedVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Elevate Your Journey',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You are currently enjoying the full spectrum of Soulmate’s emotional intelligence and personalized companionship.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Features Bento Grid
            _buildFeatureCard(
              icon: Icons.mic_external_on,
              iconColor: AppTheme.primary,
              iconBgColor: AppTheme.primaryFixed,
              title: 'Unlimited Voice Mode',
              description: "Speak freely and listen to your companion's voice without any session limits. High-fidelity audio with low latency.",
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              icon: Icons.memory,
              iconColor: AppTheme.secondary,
              iconBgColor: AppTheme.secondaryFixed,
              title: 'Deep Memory Storage',
              description: 'Your companion remembers long-term context, evolving their personality based on months of shared history.',
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              icon: Icons.self_improvement,
              iconColor: AppTheme.tertiary,
              iconBgColor: AppTheme.tertiaryFixed,
              title: 'Custom Rituals',
              description: 'Design personalized daily routines and check-ins tailored to your emotional wellness goals and schedule.',
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              icon: Icons.verified_user,
              iconColor: AppTheme.primary,
              iconBgColor: AppTheme.primaryFixed,
              title: 'Priority Support',
              description: 'Access 24/7 human-led technical assistance and early access to experimental wellness features.',
            ),

            const SizedBox(height: 40),

            // Manage Subscription
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  Text(
                    'Subscription Details',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Renewing on October 12, 2024 via App Store.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryContainer, AppTheme.secondaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: Text(
                        'Manage Subscription',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Restore Purchases',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppTheme.primaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Other Plans
            Center(
              child: Text(
                'Other Plans',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildPlanCard(
              title: 'Monthly Access',
              price: '\$9.99/mo',
            ),
            const SizedBox(height: 24),
            _buildPlanCard(
              title: 'Yearly Journey',
              price: '\$89.99/yr',
              badge: 'Save 25%',
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

  Widget _buildFeatureCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.surfaceContainer),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.surfaceContainer),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        badge.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward, color: AppTheme.outline),
        ],
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
