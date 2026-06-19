import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AiAssistantFeaturesScreen extends StatefulWidget {
  const AiAssistantFeaturesScreen({super.key});

  @override
  State<AiAssistantFeaturesScreen> createState() => _AiAssistantFeaturesScreenState();
}

class _AiAssistantFeaturesScreenState extends State<AiAssistantFeaturesScreen> with SingleTickerProviderStateMixin {
  bool _calendarIntegration = true;
  bool _emailAssistance = false;
  
  late AnimationController _blobController;
  late Animation<double> _blobAnimation;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _blobAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
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
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.1),
        titleSpacing: 24,
        title: Row(
          children: [
            ScaleTransition(
              scale: _blobAnimation,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.auto_awesome, color: Colors.white, size: 20),
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
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
                children: [
                  // Hero Section
                  Text(
                    'Enhance Your Presence',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enable your companion to handle the small details, so you can focus on the big moments.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Calendar Integration
                  _buildIntegrationCard(
                    title: 'Calendar Integration',
                    description: "I'll gently remind you of upcoming events and help find the best times for your rituals without crowding your space.",
                    icon: Icons.calendar_today,
                    iconBgColor: AppTheme.primary.withOpacity(0.1),
                    iconColor: AppTheme.primary,
                    value: _calendarIntegration,
                    onChanged: (val) => setState(() => _calendarIntegration = val),
                  ),

                  // Email Assistance
                  _buildIntegrationCard(
                    title: 'Email Assistance',
                    description: 'I can draft empathetic responses or summarize long threads, keeping your communication warm and efficient.',
                    icon: Icons.mail,
                    iconBgColor: AppTheme.secondaryContainer.withOpacity(0.2),
                    iconColor: AppTheme.secondary,
                    value: _emailAssistance,
                    onChanged: (val) => setState(() => _emailAssistance = val),
                  ),

                  // Feature Preview: Song Reminder
                  _buildSongReminderPreview(),

                  // "Complete Assistant" Summary Section
                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified, color: AppTheme.primary, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Complete Care Mode',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '"I am designed to be the quiet observer who acts only when you need it. My goal isn\'t to interrupt your life, but to handle the friction so you can stay in flow."',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Finish/Save Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 64,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 8,
                        shadowColor: AppTheme.primary.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Complete Setup',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.onPrimary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 24),
                        ],
                      ),
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

  Widget _buildIntegrationCard({
    required String title,
    required String description,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(32), // rounded-[2rem]
        boxShadow: [
          BoxShadow(
            color: value ? AppTheme.primary.withOpacity(0.2) : const Color.fromRGBO(7, 95, 171, 0.08),
            blurRadius: value ? 20 : 40,
            offset: const Offset(0, 0),
            spreadRadius: value ? 0 : -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppTheme.primary,
                activeTrackColor: AppTheme.primary.withOpacity(0.3),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongReminderPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(40), // rounded-[2.5rem]
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.music_note, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'ACTIVE SMART ACTION',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '"Remind me of this song in 10 minutes"',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300, // Placeholder for album art
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.album, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Midnight City',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'M83 • Digital Echoes',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Timer set for 09:59',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
