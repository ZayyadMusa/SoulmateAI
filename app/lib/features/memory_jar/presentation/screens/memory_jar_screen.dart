import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/glass_card.dart';
import '../../../../core/theme/app_theme.dart';

class MemoryJarScreen extends ConsumerWidget {
  const MemoryJarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: ClipRRect(
          child: BackdropFilter(
            filter: const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
            child: AppBar(
              backgroundColor: AppTheme.surface.withOpacity(0.8),
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                'Memory Jar',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: AppTheme.onSurfaceVariant),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: 0,
            left: -40,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.secondaryContainer.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              children: [
                // Top Search & Filter Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppTheme.outline),
                            const SizedBox(width: 12),
                            Text('Search memories...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.outline)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.tune, color: AppTheme.onSurface),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Timeline
                Text('This Month', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                
                _buildMemoryCard(
                  context,
                  date: 'Oct 24',
                  title: 'A perfect autumn walk',
                  content: 'The leaves were finally changing color. I walked through the park for an hour without looking at my phone once. Felt incredibly present.',
                  chipLabel: 'Peaceful',
                  chipColor: AppTheme.primaryContainer,
                  chipTextColor: AppTheme.onPrimaryContainer,
                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBoYs1nr9E-fmJxBgPdq1xawnRIvhhOtUHoH5uMXQtOAKcXEwp4XrOMuxM0ixdLTxm-Wm8MKMqQQEVjqy13wfLwQbTr52lZBbM54wmCoiGAXYO7FFFue6iRAjJ08vyamXc9yJAgqET5U6QD9tkFMqObNowxfDC9fpvdhGpM32v_6zClhcs2MSBEPGdbDC7B7Sc3q8BSz7LlKDOm76NnmdaVwhZ7Tko8E6rMRV23pKYv2k-PvwtTTu25606LqAOIKJAWi3XCmT1IAlE',
                ),
                const SizedBox(height: 24),
                
                _buildMemoryCard(
                  context,
                  date: 'Oct 18',
                  title: 'Overcame the anxiety spike',
                  content: 'Started feeling overwhelmed before the big presentation, but I used the 4-7-8 breathing technique. It actually worked this time.',
                  chipLabel: 'Growth',
                  chipColor: AppTheme.tertiaryContainer,
                  chipTextColor: AppTheme.onTertiaryContainer,
                ),
                const SizedBox(height: 24),
                
                Text('September', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                
                _buildMemoryCard(
                  context,
                  date: 'Sep 30',
                  title: 'Coffee with old friends',
                  content: 'Laughed until my sides hurt. It is amazing how some connections never fade no matter how much time passes.',
                  chipLabel: 'Joy',
                  chipColor: AppTheme.secondaryContainer,
                  chipTextColor: AppTheme.onSecondaryContainer,
                ),
                const SizedBox(height: 80), // bottom nav spacing
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Add Memory'),
        ),
      ),
    );
  }

  Widget _buildMemoryCard(
    BuildContext context, {
    required String date,
    required String title,
    required String content,
    required String chipLabel,
    required Color chipColor,
    required Color chipTextColor,
    String? imageUrl,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: Theme.of(context).textTheme.labelSmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: chipColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  chipLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: chipTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20)),
          const SizedBox(height: 8),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
          if (imageUrl != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  width: double.infinity,
                  color: AppTheme.surfaceContainerHigh,
                  child: const Center(child: Icon(Icons.image, color: AppTheme.outline)),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
