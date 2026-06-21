import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class DailyReflectionScreen extends StatefulWidget {
  const DailyReflectionScreen({super.key});

  @override
  State<DailyReflectionScreen> createState() => _DailyReflectionScreenState();
}

class _DailyReflectionScreenState extends State<DailyReflectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartScaleAnimation;
  late Animation<double> _heartBorderAnimation;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    
    _heartScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );

    _heartBorderAnimation = Tween<double>(begin: 0.4, end: 0.6).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.1),
        titleSpacing: 24,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryContainer],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Soulmate AI',
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
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Floating Background Elements
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: -80,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 1.2),
              duration: const Duration(seconds: 4),
              builder: (context, val, child) {
                return Transform.scale(
                  scale: val,
                  child: child,
                );
              },
              child: Container(
                width: 384,
                height: 384,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.15),
                      blurRadius: 100,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: -80,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 1.2),
              duration: const Duration(seconds: 4),
              builder: (context, val, child) {
                return Transform.scale(
                  scale: val,
                  child: child,
                );
              },
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryContainer.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondaryContainer.withOpacity(0.15),
                      blurRadius: 100,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
              children: [
                // Hero: Mood Reflection
                Center(
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: _heartScaleAnimation,
                        child: AnimatedBuilder(
                          animation: _heartBorderAnimation,
                          builder: (context, child) {
                            return Container(
                              width: 192,
                              height: 192,
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppTheme.primaryContainer, AppTheme.secondaryContainer],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(192 * _heartBorderAnimation.value),
                                  topRight: Radius.circular(192 * (1 - _heartBorderAnimation.value)),
                                  bottomLeft: Radius.circular(192 * 0.3),
                                  bottomRight: Radius.circular(192 * 0.7),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primaryContainer.withOpacity(0.4),
                                    blurRadius: 32,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.favorite, color: Colors.white, size: 48),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Feeling Serene',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Today felt balanced and calm.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "You navigated today with a sense of quiet confidence. Let's look back at the light you brought into the world.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // Bento Grid Wins
                Row(
                  children: [
                    const Icon(Icons.military_tech, color: AppTheme.primary, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Daily Wins',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Grid of Wins
                _buildWinCard(
                  icon: Icons.menu_book,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primary.withOpacity(0.1),
                  title: 'Morning Habit',
                  description: 'Read 15 pages of your book before checking your phone. A peaceful start.',
                ),
                const SizedBox(height: 16),
                _buildHighlightWinCard(
                  imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&q=80',
                  title: 'Outdoor Connection',
                  description: "You took a 45-minute walk in the park. Your heart rate stayed in a healthy zone, and you noted feeling 'grounded' afterwards.",
                  badgeText: 'Major Milestone',
                ),
                const SizedBox(height: 16),
                _buildWinCard(
                  icon: Icons.groups,
                  iconColor: AppTheme.tertiary,
                  iconBgColor: AppTheme.tertiaryContainer.withOpacity(0.1),
                  title: 'Social Energy',
                  description: 'Shared a meaningful lunch with Sarah. Your social battery was charged by the deep conversation.',
                ),
                const SizedBox(height: 16),
                _buildWinCard(
                  icon: Icons.self_improvement,
                  iconColor: AppTheme.secondary,
                  iconBgColor: AppTheme.secondaryContainer.withOpacity(0.1),
                  title: 'Mindful Choice',
                  description: 'You chose herbal tea over a third coffee. Your future self thanks you for the better sleep tonight.',
                ),
                const SizedBox(height: 16),
                _buildWinCard(
                  icon: Icons.done_all,
                  iconColor: AppTheme.error,
                  iconBgColor: AppTheme.errorContainer.withOpacity(0.1),
                  title: 'Task Management',
                  description: "Completed the difficult report you've been putting off for three days. Relief achieved.",
                ),

                const SizedBox(height: 48),

                // AI Prompt Section
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.08),
                        blurRadius: 64,
                        offset: const Offset(0, 32),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "SOULMATE'S WHISPER",
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppTheme.primary,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "What's one thing you want to remember for tomorrow?",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Type your thought here...',
                              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.outline,
                              ),
                              filled: true,
                              fillColor: AppTheme.surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildPromptChip('"I am capable"'),
                          _buildPromptChip('"Rest is productive"'),
                          _buildPromptChip('"Progress over perfection"'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // Final Gratitude Callout
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          elevation: 8,
                          shadowColor: AppTheme.primary.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Save Reflection',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppTheme.onPrimary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.check_circle_outline, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Day 42 of your journey. You're doing great.",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
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

    );
  }

  Widget _buildWinCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.04),
            blurRadius: 64,
            offset: const Offset(0, 32),
          ),
        ],
      ),
      child: Row(
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightWinCard({
    required String imageUrl,
    required String title,
    required String description,
    required String badgeText,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.04),
            blurRadius: 64,
            offset: const Offset(0, 32),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.secondaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              badgeText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSecondaryFixedVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildPromptChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.onSurface,
        ),
      ),
    );
  }

}
