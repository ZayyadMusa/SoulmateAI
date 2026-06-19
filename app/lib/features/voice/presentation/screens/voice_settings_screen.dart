import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VoiceSettingsScreen extends StatefulWidget {
  const VoiceSettingsScreen({super.key});

  @override
  State<VoiceSettingsScreen> createState() => _VoiceSettingsScreenState();
}

class _VoiceSettingsScreenState extends State<VoiceSettingsScreen> with SingleTickerProviderStateMixin {
  int _selectedVoiceIndex = 0;
  double _speedValue = 1.0;
  bool _handsFree = true;
  bool _soundEffects = true;
  Color _orbColor = const Color(0xFF075fab);

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Color> _orbColors = [
    const Color(0xFF075fab), // Primary
    const Color(0xFFa4c9ff), // Primary Fixed Dim
    const Color(0xFFffb4ab), // Error (Using as light coral here)
    const Color(0xFFfeb246), // Secondary Container
    const Color(0xFF3a6a00), // Tertiary
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        scrolledUnderElevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () {},
        ),
        title: Text(
          'Voice Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.onSurface,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: AppTheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
          children: [
            // Companion Voice Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Companion Voice',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '4 Voices Available',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _buildVoiceCard(
                    index: 0,
                    icon: Icons.record_voice_over,
                    title: 'Warm & Gentle',
                    description: 'Soft, empathetic, and soothing tones.',
                  ),
                  const SizedBox(width: 16),
                  _buildVoiceCard(
                    index: 1,
                    icon: Icons.keyboard_voice,
                    title: 'Calm & Balanced',
                    description: 'Balanced, professional, and clear.',
                  ),
                  const SizedBox(width: 16),
                  _buildVoiceCard(
                    index: 2,
                    icon: Icons.sentiment_satisfied,
                    title: 'Bright & Cheerful',
                    description: 'Energetic, friendly, and upbeat.',
                  ),
                  const SizedBox(width: 16),
                  _buildVoiceCard(
                    index: 3,
                    icon: Icons.settings_input_antenna,
                    title: 'Deep & Resonant',
                    description: 'Rich, authoritative, and grounded.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Speaking Speed Slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.surfaceVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.speed, color: AppTheme.primary, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Speaking Speed',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryFixed,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          '${_speedValue.toStringAsFixed(1)}x',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppTheme.primary,
                      inactiveTrackColor: AppTheme.surfaceVariant,
                      thumbColor: AppTheme.primary,
                      overlayColor: AppTheme.primary.withOpacity(0.2),
                      trackHeight: 4.0,
                    ),
                    child: Slider(
                      value: _speedValue,
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      onChanged: (val) {
                        setState(() {
                          _speedValue = val;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Slow', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline)),
                      Text('Fast', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Toggles Section
            Row(
              children: [
                Expanded(
                  child: _buildToggleCard(
                    icon: Icons.hearing,
                    title: 'Hands-free',
                    subtitle: 'Auto-detect speech',
                    value: _handsFree,
                    onChanged: (val) {
                      setState(() {
                        _handsFree = val;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildToggleCard(
                    icon: Icons.graphic_eq,
                    title: 'Sound Effects',
                    subtitle: 'Ambient feedback',
                    value: _soundEffects,
                    onChanged: (val) {
                      setState(() {
                        _soundEffects = val;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Voice Mode Theme (Soul Orb)
            Text(
              'Voice Mode Theme',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.surfaceVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ScaleTransition(
                            scale: _pulseAnimation,
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    _orbColor,
                                    _orbColor.withOpacity(0.0),
                                  ],
                                  stops: const [0.3, 1.0],
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.auto_awesome, color: AppTheme.primary.withOpacity(0.3), size: 36),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _orbColors.map((color) {
                      final isSelected = _orbColor == color;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _orbColor = color;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 4)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primary.withOpacity(0.5),
                                      blurRadius: 0,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select a visual aura for your companion',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
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
          border: const Border(top: BorderSide(color: AppTheme.outlineVariant)),
        ),
        padding: const EdgeInsets.only(bottom: 24, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.forum_outlined, 'Chat', false),
            _buildNavItem(Icons.settings_voice, 'Voice', true),
            _buildNavItem(Icons.psychology_outlined, 'Memory', false),
            _buildNavItem(Icons.settings_outlined, 'Settings', false),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceCard({
    required int index,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedVoiceIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVoiceIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 256,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.surfaceVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 12,
                offset: const Offset(0, 4),
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
                    color: isSelected ? AppTheme.primaryFixed : AppTheme.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? AppTheme.onPrimaryFixedVariant : AppTheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : AppTheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: isSelected ? AppTheme.onPrimary : AppTheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Row(
                children: [
                  Container(
                    height: 4,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SELECTED',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.tertiaryFixed,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.onTertiaryFixedVariant,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppTheme.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppTheme.surfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
