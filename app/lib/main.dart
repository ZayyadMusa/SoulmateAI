import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/local_storage/local_storage_service.dart';
import 'features/daily_reflection/presentation/screens/daily_reflection_screen.dart';
import 'features/memory_jar/presentation/screens/memory_jar_screen.dart';
import 'features/voice_mode/presentation/screens/active_session_screen.dart';
import 'features/nocturnal_mode/presentation/screens/nocturnal_screen.dart';

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
      const NocturnalScreen(),
    ];

    return MaterialApp(
      title: 'Holistic Life Companion',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: screens[currentIndex.value],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex.value,
          onDestinationSelected: (index) => currentIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: 'Reflection'),
            NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Memory Jar'),
            NavigationDestination(icon: Icon(Icons.record_voice_over_outlined), label: 'Voice'),
            NavigationDestination(icon: Icon(Icons.nights_stay_outlined), label: 'Nocturnal'),
          ],
        ),
      ),
    );
  }
}
