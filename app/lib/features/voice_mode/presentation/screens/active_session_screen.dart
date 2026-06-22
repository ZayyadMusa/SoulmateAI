import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/voice_session_controller.dart';
import '../widgets/pulsing_avatar.dart';
import 'voice_settings_screen.dart';

class ActiveSessionScreen extends HookConsumerWidget {
  const ActiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(voiceSessionControllerProvider);
    final theme = Theme.of(context);

    String statusText;
    switch (sessionState) {
      case SessionState.idle:
        statusText = 'Tap to talk';
        break;
      case SessionState.listening:
        statusText = 'I am listening...';
        break;
      case SessionState.processing:
        statusText = 'Thinking...';
        break;
      case SessionState.speaking:
        statusText = 'Aura is speaking...';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Companion'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: theme.colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VoiceSettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (sessionState == SessionState.idle) {
                  ref.read(voiceSessionControllerProvider.notifier).startListening();
                } else {
                  ref.read(voiceSessionControllerProvider.notifier).stop();
                }
              },
              child: PulsingAvatar(sessionState: sessionState),
            ),
            const SizedBox(height: 64),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                statusText,
                key: ValueKey(statusText),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
