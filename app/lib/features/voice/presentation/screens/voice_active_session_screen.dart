import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VoiceActiveSessionScreen extends StatefulWidget {
  const VoiceActiveSessionScreen({super.key});

  @override
  State<VoiceActiveSessionScreen> createState() => _VoiceActiveSessionScreenState();
}

class _VoiceActiveSessionScreenState extends State<VoiceActiveSessionScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _morphController;
  late AnimationController _waveController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _morphRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.6, end: 0.8).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _morphRadiusAnimation = Tween<double>(begin: 0.4, end: 0.7).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOut),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _morphController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Atmospheric Layer
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.primaryFixed.withOpacity(0.5),
                      AppTheme.secondaryFixed.withOpacity(0.3),
                      AppTheme.background,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    center: const Alignment(0, -0.3),
                    radius: 1.5,
                  ),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.waving_hand, color: AppTheme.onPrimaryContainer, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Soulmate AI',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.spatial_audio_off, color: AppTheme.onSurfaceVariant, size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Hands-free Active',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppTheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppTheme.surfaceContainerHigh,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Soul Orb
                      SizedBox(
                        width: 288,
                        height: 288,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ScaleTransition(
                              scale: _pulseAnimation,
                              child: Container(
                                width: 288,
                                height: 288,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryContainer.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            ScaleTransition(
                              scale: Tween<double>(begin: 0.8, end: 1.0).animate(_pulseController),
                              child: Container(
                                width: 230,
                                height: 230,
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryContainer.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _morphController,
                              builder: (context, child) {
                                return Container(
                                  width: 192,
                                  height: 192,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppTheme.primary, AppTheme.primaryContainer, AppTheme.secondaryContainer],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(192 * _morphRadiusAnimation.value),
                                      topRight: Radius.circular(192 * (1 - _morphRadiusAnimation.value)),
                                      bottomLeft: Radius.circular(192 * 0.3),
                                      bottomRight: Radius.circular(192 * 0.7),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primary.withOpacity(0.3),
                                        blurRadius: 32,
                                        offset: const Offset(0, 16),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(160 * (1 - _morphRadiusAnimation.value)),
                                          topRight: Radius.circular(160 * _morphRadiusAnimation.value),
                                          bottomLeft: Radius.circular(160 * 0.7),
                                          bottomRight: Radius.circular(160 * 0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Dynamic Transcription
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              '"I\'m listening. Tell me more about that walk in the park..."',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'AI is thinking and listening',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Controls & Visualization
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      // Waveform Visualization
                      SizedBox(
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(7, (index) {
                            return AnimatedBuilder(
                              animation: _waveController,
                              builder: (context, child) {
                                final delay = index * 0.1;
                                final val = math.sin((_waveController.value * math.pi * 2) + delay);
                                final height = 10 + (val + 1) * 10;
                                return Container(
                                  width: 6,
                                  height: height,
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0 ? AppTheme.primary : AppTheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: AppTheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.mic_off, color: AppTheme.onSurfaceVariant, size: 28),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 24),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call_end, size: 24),
                            label: const Text('End Session'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.errorContainer,
                              foregroundColor: AppTheme.onErrorContainer,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              elevation: 8,
                              shadowColor: AppTheme.errorContainer.withOpacity(0.4),
                              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: AppTheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.volume_up, color: AppTheme.onSurfaceVariant, size: 28),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Mode Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppTheme.tertiary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Walk & Talk Mode',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
