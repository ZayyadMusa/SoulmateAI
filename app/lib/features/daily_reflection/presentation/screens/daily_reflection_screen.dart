import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/glass_card.dart';
import '../../../../core/presentation/widgets/morphing_heart.dart';
import '../../../../core/theme/app_theme.dart';

class DailyReflectionScreen extends StatelessWidget {
  const DailyReflectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: ClipRRect(
          child: BackdropFilter(
            filter: AppTheme.lightTheme.colorScheme.surface == AppTheme.surface ? 
               // Simulated blur effect
               const ColorFilter.mode(Colors.transparent, BlendMode.multiply) : 
               const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
            child: AppBar(
              backgroundColor: AppTheme.surface.withOpacity(0.8),
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryContainer],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.auto_awesome, color: Colors.white, size: 20),
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
                  icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
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
          const GlowBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hero Section
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 192,
                    height: 192,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const MorphingHeart(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.favorite, color: Colors.white, size: 60),
                            const SizedBox(height: 8),
                            Text(
                              'Feeling Serene',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Today felt balanced and calm.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You navigated today with a sense of quiet confidence. Let's look back at the light you brought into the world.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 40),

                  // Bento Grid
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.military_tech, color: AppTheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Daily Wins',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Wrap simulating the grid
                  _buildWinCard(
                    context,
                    icon: Icons.menu_book,
                    iconColor: AppTheme.primary,
                    bgColor: AppTheme.primary.withOpacity(0.1),
                    title: 'Morning Habit',
                    subtitle: 'Read 15 pages of your book before checking your phone. A peaceful start.',
                  ),
                  const SizedBox(height: 24),
                  
                  // Highlight card
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 128,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.secondaryContainer.withOpacity(0.3),
                          ),
                          child: const Center(child: Icon(Icons.nature_people, size: 48, color: AppTheme.secondary)),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryContainer.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Major Milestone',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSecondaryFixedVariant),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Outdoor Connection', style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 4),
                        Text(
                          "You took a 45-minute walk in the park. Your heart rate stayed in a healthy zone, and you noted feeling 'grounded' afterwards.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildWinCard(
                    context,
                    icon: Icons.groups,
                    iconColor: AppTheme.tertiary,
                    bgColor: AppTheme.tertiaryContainer.withOpacity(0.1),
                    title: 'Social Energy',
                    subtitle: 'Shared a meaningful lunch with Sarah. Your social battery was charged by the deep conversation.',
                  ),
                  const SizedBox(height: 24),
                  
                  _buildWinCard(
                    context,
                    icon: Icons.self_improvement,
                    iconColor: AppTheme.secondary,
                    bgColor: AppTheme.secondaryContainer.withOpacity(0.1),
                    title: 'Mindful Choice',
                    subtitle: 'You chose herbal tea over a third coffee. Your future self thanks you for the better sleep tonight.',
                  ),
                  const SizedBox(height: 24),
                  
                  _buildWinCard(
                    context,
                    icon: Icons.done_all,
                    iconColor: AppTheme.error,
                    bgColor: AppTheme.errorContainer.withOpacity(0.1),
                    title: 'Task Management',
                    subtitle: 'Completed the difficult report you\'ve been putting off for three days. Relief achieved.',
                  ),
                  
                  const SizedBox(height: 40),

                  // Prompt Section
                  GlassCard(
                    padding: const EdgeInsets.all(32),
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
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "What's one thing you want to remember for tomorrow?",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your thought here...',
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_forward, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildChip(context, '"I am capable"'),
                            _buildChip(context, '"Rest is productive"'),
                            _buildChip(context, '"Progress over perfection"'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Save Reflection'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Day 42 of your journey. You're doing great.",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWinCard(BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
