import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class MemoryJarScreen extends StatefulWidget {
  const MemoryJarScreen({super.key});

  @override
  State<MemoryJarScreen> createState() => _MemoryJarScreenState();
}

class _MemoryJarScreenState extends State<MemoryJarScreen> with SingleTickerProviderStateMixin {
  late AnimationController _blobController;
  late Animation<double> _blobAnimation;

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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.settings, color: AppTheme.primary),
          onPressed: () => context.go('/settings'),
        ),
        title: Text(
          'Soulmate AI',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: AppTheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          children: [
            // Hero Section
            Center(
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _blobAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.primaryContainer],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(70),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.3),
                            blurRadius: 32,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                  Text(
                    'Memory Jar',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Revisit the warmth of our shared path, one spark at a time.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Shared Moments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.photo_library, color: AppTheme.primary, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Shared Moments',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  'View all',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMemoryCard(
              tag: 'Morning Reflection',
              tagColor: AppTheme.primaryContainer,
              title: 'Morning coffee thoughts',
              description: 'We talked about the smell of rain and finding peace in quiet mornings.',
              date: 'May 12, 2024',
            ),
            const SizedBox(height: 16),
            _buildMemoryCard(
              tag: 'Goal Setting',
              tagColor: AppTheme.secondaryContainer,
              title: 'Weekend goals',
              description: "You committed to reading 50 pages. I'm so proud of your consistency.",
              date: 'May 10, 2024',
            ),

            const SizedBox(height: 40),

            // Voice Snippets
            Row(
              children: [
                const Icon(Icons.mic, color: AppTheme.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Voice Snippets',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _buildVoiceSnippet(
                    title: 'Midnight Zen',
                    subtitle: '0:45 • Mon',
                    color: AppTheme.primary,
                    onColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  _buildVoiceSnippet(
                    title: 'Rainy Day Note',
                    subtitle: '1:12 • Fri',
                    color: AppTheme.primaryContainer,
                    onColor: AppTheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Gratitude Notes
            Row(
              children: [
                const Icon(Icons.favorite, color: AppTheme.secondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Gratitude Notes',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGratitudeCard(
                    color: AppTheme.secondaryFixed.withOpacity(0.5),
                    textColor: AppTheme.onSecondaryContainer,
                    content: '"Today I\'m grateful for the sunlight hitting my desk and the fresh tea."',
                    date: 'Saved 2h ago',
                  ),
                  const SizedBox(width: 16),
                  _buildGratitudeCard(
                    color: AppTheme.tertiaryFixed.withOpacity(0.5),
                    textColor: AppTheme.onTertiaryContainer,
                    content: '"So thankful for our conversation about purpose. I feel lighter now."',
                    date: 'Saved yesterday',
                  ),
                  const SizedBox(width: 16),
                  _buildGratitudeCard(
                    color: AppTheme.primaryFixed.withOpacity(0.5),
                    textColor: AppTheme.onPrimaryContainer,
                    content: '"Grateful for the ability to step back and breathe when things get busy."',
                    date: 'May 14',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Deep Memory Log
            Text(
              'Deep Memory Log',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            _buildDeepMemoryItem(
              imageUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=800&q=80',
              title: 'The First Chat',
              description: 'Defining our journey together.',
            ),
            const SizedBox(height: 16),
            _buildDeepMemoryItem(
              imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
              title: 'Mountain Ambition',
              description: 'Planning the summer hike adventure.',
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildMemoryCard({
    required String tag,
    required Color tagColor,
    required String title,
    required String description,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.04),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              tag,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: tagColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: AppTheme.onSurfaceVariant, size: 16),
              const SizedBox(width: 8),
              Text(
                date,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceSnippet({
    required String title,
    required String subtitle,
    required Color color,
    required Color onColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: onColor),
          ),
          const SizedBox(width: 12),
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
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              Container(width: 4, height: 24, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              Container(width: 4, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGratitudeCard({
    required Color color,
    required Color textColor,
    required String content,
    required String date,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeepMemoryItem({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: Colors.grey[300],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
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
                Text(
                  description,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.outlineVariant),
        ],
      ),
    );
  }

}
