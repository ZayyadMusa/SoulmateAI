import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/scaffold_with_nav_bar.dart';

// Import screens
import '../../features/daily_reflection/presentation/screens/daily_reflection_screen.dart';
import '../../features/memory_jar/presentation/screens/memory_jar_screen.dart';
import '../../features/voice_mode/presentation/screens/voice_active_session_screen.dart';
import '../../features/voice_mode/presentation/screens/voice_settings_screen.dart';
import '../../features/supportive_chat/presentation/screens/supportive_chat_screen.dart';
import '../../features/supportive_chat/presentation/screens/email_assistance_chat_screen.dart';
import '../../features/settings/presentation/screens/data_export_screen.dart';
import '../../features/settings/presentation/screens/encryption_keys_screen.dart';
import '../../features/subscription/presentation/screens/premium_subscription_screen.dart';
import '../../features/rituals/presentation/screens/rituals_memories_screen.dart';
import '../../features/assistant/presentation/screens/ai_assistant_features_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/reflection',
  routes: [
    // Standalone routes (no bottom nav)
    GoRoute(
      path: '/email-assistance',
      builder: (context, state) => const EmailAssistanceChatScreen(),
    ),
    GoRoute(
      path: '/voice-settings',
      builder: (context, state) => const VoiceSettingsScreen(),
    ),
    GoRoute(
      path: '/encryption-keys',
      builder: (context, state) => const EncryptionKeysScreen(),
    ),
    GoRoute(
      path: '/premium-subscription',
      builder: (context, state) => const PremiumSubscriptionScreen(),
    ),
    GoRoute(
      path: '/rituals',
      builder: (context, state) => const RitualsMemoriesScreen(),
    ),
    GoRoute(
      path: '/ai-assistant',
      builder: (context, state) => const AiAssistantFeaturesScreen(),
    ),

    // Bottom Navigation routes
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Reflect
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reflection',
              builder: (context, state) => const DailyReflectionScreen(),
            ),
          ],
        ),
        // Tab 1: Memory Jar
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/memory-jar',
              builder: (context, state) => const MemoryJarScreen(),
            ),
          ],
        ),
        // Tab 2: Voice / Soulmate
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/voice',
              builder: (context, state) => const VoiceActiveSessionScreen(),
            ),
          ],
        ),
        // Tab 3: Chat
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const SupportiveChatScreen(),
            ),
          ],
        ),
        // Tab 4: Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const DataExportScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
