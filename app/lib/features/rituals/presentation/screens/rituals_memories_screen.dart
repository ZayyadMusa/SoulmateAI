import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RitualsMemoriesScreen extends StatefulWidget {
  const RitualsMemoriesScreen({super.key});

  @override
  State<RitualsMemoriesScreen> createState() => _RitualsMemoriesScreenState();
}

class _RitualsMemoriesScreenState extends State<RitualsMemoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _blobController;
  late Animation<double> _blobAnimation;

  bool _drinkWaterDone = true;
  bool _dailyStretchDone = false;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _blobAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _blobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // In Flutter, using a Scaffold with a Row for md:col-span-8 and md:col-span-4 is handled via LayoutBuilder or a SingleChildScrollView.
    // For simplicity on a mobile screen view, we'll stack them vertically. The design says "grid-cols-1 md:grid-cols-12",
    // so on standard mobile (grid-cols-1) they just stack.

    return Scaffold(
      backgroundColor: AppTheme.surface,
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
                color: AppTheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, val, child) {
                    return Opacity(
                      opacity: val,
                      child: child,
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.secondaryContainer],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.tertiaryContainer.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              children: [
                const Icon(Icons.sync, color: AppTheme.tertiary, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Calendar Sync Active',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 16, left: 8),
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          children: [
            // Hero Header
            Text(
              'Daily Rituals',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your gentle space for small wins, intentional focus, and cherished memories.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 40),

            // Morning Rituals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MORNING RITUALS',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  '2 of 4 done',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildRitualCard(
                    icon: Icons.water_drop,
                    iconColor: AppTheme.primary,
                    iconBgColor: AppTheme.primaryFixed,
                    title: 'Drink water',
                    subtitle: 'Start with 500ml of hydration',
                    isDone: _drinkWaterDone,
                    onTap: () {
                      setState(() {
                        _drinkWaterDone = !_drinkWaterDone;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildRitualCard(
                    icon: Icons.self_improvement,
                    iconColor: AppTheme.secondary,
                    iconBgColor: AppTheme.secondaryFixed,
                    title: 'Daily Stretch',
                    subtitle: '5 minutes of soft movement',
                    isDone: _dailyStretchDone,
                    onTap: () {
                      setState(() {
                        _dailyStretchDone = !_dailyStretchDone;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Daily Tasks Section
            Text(
              'DAILY TASKS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.04),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTaskItem(
                    icon: Icons.mail_outline,
                    title: 'Send email to Sarah',
                    subtitle: 'Regarding the project update',
                  ),
                  const Divider(color: AppTheme.surfaceContainerLow, height: 1),
                  _buildTaskItem(
                    icon: Icons.shopping_basket_outlined,
                    title: 'Buy ingredients for dinner',
                    subtitle: 'Pasta and fresh basil',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Memories Section
            Text(
              'MEMORIES',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    right: -40,
                    child: ScaleTransition(
                      scale: _blobAnimation,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMemoryItem(
                        icon: Icons.music_note,
                        iconColor: AppTheme.secondary,
                        title: 'A song I loved today',
                        content: '"Midsummer Echoes" by The Horizon — felt like driving through a warm sunset.',
                      ),
                      const SizedBox(height: 24),
                      _buildMemoryItem(
                        icon: Icons.auto_stories,
                        iconColor: AppTheme.tertiary,
                        title: 'Daily Gratitude',
                        content: 'The smell of coffee at 7 AM. The quiet before the world wakes up.',
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=800&q=80',
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Prominent Soft FAB
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.onPrimary,
          elevation: 8,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.chat_bubble_outline, 'Chat', false),
            _buildNavItem(Icons.auto_awesome_mosaic, 'Rituals', true),
            _buildNavItem(Icons.auto_stories_outlined, 'Reflection', false),
            _buildNavItem(Icons.calendar_today_outlined, 'Calendar', false),
          ],
        ),
      ),
    );
  }

  Widget _buildRitualCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required bool isDone,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.04),
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
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone ? AppTheme.primaryContainer : AppTheme.outlineVariant,
                    width: 2,
                  ),
                  color: isDone ? AppTheme.primary : Colors.transparent,
                ),
                child: isDone
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppTheme.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.outline, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.circle_outlined, color: AppTheme.outlineVariant, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: isActive ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
