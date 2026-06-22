import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/local_storage/local_storage_service.dart';
import 'features/daily_reflection/presentation/screens/daily_reflection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  
  runApp(
    const ProviderScope(
      child: HolisticLifeCompanionApp(),
    ),
  );
}

class HolisticLifeCompanionApp extends StatelessWidget {
  const HolisticLifeCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holistic Life Companion',
      theme: AppTheme.lightTheme,
      home: const DailyReflectionScreen(),
    );
  }
}
