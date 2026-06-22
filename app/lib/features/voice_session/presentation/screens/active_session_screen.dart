import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/morphing_heart.dart';
import '../../../../core/theme/app_theme.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  ConsumerState<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  @override
  Widget build(BuildContext context) {
    const Color darkBg = Color(0xFF191C1E); // onSurface used as dark bg
    const Color darkSurface = Color(0xFF2D3133); // inverseSurface

    return Scaffold(
      backgroundColor: darkBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Dark glow
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryContainer.withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  )
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Listening...',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '00:42',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                
                // Huge Morphing Heart for Voice
                SizedBox(
                  width: 250,
                  height: 250,
                  child: const MorphingHeart(),
                ),
                
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: darkSurface,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.mic_off, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 32),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppTheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 32,
                        icon: const Icon(Icons.stop, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 32),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: darkSurface,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
