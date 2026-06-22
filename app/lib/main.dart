import 'dart:ui' as dart_ui;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/local_storage/local_storage_service.dart';
import 'features/daily_reflection/presentation/screens/daily_reflection_screen.dart';
import 'features/memory_jar/presentation/screens/memory_jar_screen.dart';
import 'features/voice_mode/presentation/screens/active_session_screen.dart';
import 'features/nocturnal_mode/presentation/screens/nocturnal_screen.dart';
import 'features/supportive_chat/presentation/screens/supportive_chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  
  runApp(
    const ProviderScope(
      child: HolisticLifeCompanionApp(),
    ),
  );
}

class HolisticLifeCompanionApp extends HookWidget {
  const HolisticLifeCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    final screens = [
      const DailyReflectionScreen(),
      const MemoryJarScreen(),
      const ActiveSessionScreen(),
      const SupportiveChatScreen(),
      const NocturnalScreen(),
    ];

    return MaterialApp(
      title: 'Holistic Life Companion',
      theme: AppTheme.lightTheme,
      home: Scaffold(
      body: Stack(
          children: [
            screens[currentIndex.value],
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: BackdropFilter(
                  filter: dart_ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 24, top: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF075FAB).withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(context, Icons.auto_stories, 'Reflection', 0, currentIndex),
                        _buildNavItem(context, Icons.inventory_2_outlined, 'Memory Jar', 1, currentIndex),
                        _buildNavItem(context, Icons.record_voice_over_outlined, 'Voice', 2, currentIndex),
                        _buildNavItem(context, Icons.chat_bubble_outline, 'Chat', 3, currentIndex),
                        _buildNavItem(context, Icons.nights_stay_outlined, 'Nocturnal', 4, currentIndex),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index, ValueNotifier<int> currentIndex) {
    final isSelected = currentIndex.value == index;
    return GestureDetector(
      onTap: () => currentIndex.value = index,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              icon,
              color: isSelected ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
