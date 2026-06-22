import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/repositories/voice_profile_repository.dart';
import '../widgets/voice_profile_card.dart';

class VoiceSettingsScreen extends HookConsumerWidget {
  const VoiceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We use a refresh trigger to force rebuilds when selecting a profile
    final refreshTrigger = useState(0);
    final repository = ref.watch(voiceProfileRepositoryProvider);
    final profiles = repository.getAllProfiles();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Profiles'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return VoiceProfileCard(
            profile: profile,
            onSelect: () async {
              await repository.selectProfile(profile.id);
              refreshTrigger.value++; // Force rebuild
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Switched to ${profile.name}'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
