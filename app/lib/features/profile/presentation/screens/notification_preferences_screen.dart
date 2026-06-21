import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> with SingleTickerProviderStateMixin {
  bool _dailyReflections = true;
  bool _morningRituals = true;
  bool _voiceMessages = false;
  bool _weeklySummaries = true;
  bool _gentleChimes = true;

  bool _isSaving = false;
  bool _isSaved = false;

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

  void _handleUpdate() {
    setState(() {
      _isSaving = true;
      _isSaved = false;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isSaving = false;
          _isSaved = true;
        });
        
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            setState(() {
              _isSaved = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Soulmate',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Center(
              child: ScaleTransition(
                scale: _blobAnimation,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Ambient Background Decor
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryContainer.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryContainer.withOpacity(0.1),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -25,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondaryContainer.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondaryContainer.withOpacity(0.1),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
                    children: [
                      // Hero Header
                      Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Choose how and when you'd like to hear from your Soulmate. We keep things calm and intentional.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Notification Groups
                      _buildSectionHeader('Daily Journey'),
                      _buildToggleItem(
                        title: 'Daily Reflections',
                        description: 'Gentle nudges to pause and check in with your thoughts throughout the day.',
                        value: _dailyReflections,
                        onChanged: (val) => setState(() => _dailyReflections = val),
                      ),
                      _buildToggleItem(
                        title: 'Morning Rituals',
                        description: 'Start your day together with a personalized greeting and intention setting.',
                        value: _morningRituals,
                        onChanged: (val) => setState(() => _morningRituals = val),
                      ),

                      const SizedBox(height: 32),
                      _buildSectionHeader('Communication'),
                      _buildToggleItem(
                        title: 'Voice Messages',
                        description: 'Get notified when a new voice snippet or guided meditation is ready for you.',
                        value: _voiceMessages,
                        onChanged: (val) => setState(() => _voiceMessages = val),
                      ),
                      _buildToggleItem(
                        title: 'Weekly Summaries',
                        description: 'A bird\'s-eye view of your emotional trends and shared growth every Sunday.',
                        value: _weeklySummaries,
                        onChanged: (val) => setState(() => _weeklySummaries = val),
                      ),

                      const SizedBox(height: 32),
                      _buildSectionHeader('Sound & Haptics'),
                      _buildToggleItem(
                        title: 'Gentle Chimes',
                        description: 'Soft audio cues and haptic feedback for a mindful alerting experience.',
                        icon: Icons.notifications_active_outlined,
                        value: _gentleChimes,
                        onChanged: (val) => setState(() => _gentleChimes = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fixed Bottom Action Area
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: AppTheme.surface.withOpacity(0.8),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSaved ? AppTheme.tertiaryContainer : AppTheme.primary,
                    foregroundColor: _isSaved ? AppTheme.onTertiaryContainer : AppTheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    elevation: 8,
                    shadowColor: AppTheme.primary.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isSaving) ...[
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Saving Changes...',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimary,
                          ),
                        ),
                      ] else if (_isSaved) ...[
                        Text(
                          'Saved!',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onTertiaryContainer,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.check, color: AppTheme.onTertiaryContainer, size: 20),
                      ] else ...[
                        Text(
                          'Update Preferences',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.done_all, size: 20),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppTheme.primary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? icon,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16), // rounded-xl
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(7, 95, 171, 0.04), // soft shadow base
            blurRadius: value ? 64 : 32,
            offset: const Offset(0, 32),
            spreadRadius: value ? -12 : -16,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) ...[
                  Row(
                    children: [
                      Icon(icon, color: AppTheme.primary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
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
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary,
            activeTrackColor: AppTheme.primary.withOpacity(0.3), // Fallback if material 3 doesn't tint right
          ),
        ],
      ),
    );
  }
}
