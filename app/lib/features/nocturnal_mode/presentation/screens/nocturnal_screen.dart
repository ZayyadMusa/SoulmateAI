import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../controllers/nocturnal_controller.dart';
import '../widgets/sound_scape_card.dart';
import '../widgets/dream_card.dart';

class NocturnalScreen extends HookConsumerWidget {
  const NocturnalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nocturnalAsync = ref.watch(nocturnalControllerProvider);
    final dreamController = useTextEditingController();
    
    // We create a dark theme locally for this screen to match DESIGN.md "Midnight Navy"
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A1128),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8F9BB3),
        brightness: Brightness.dark,
        surface: const Color(0xFF1E2640),
        primary: const Color(0xFF8F9BB3),
      ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.white70,
        displayColor: Colors.white,
      ),
    );

    return Theme(
      data: darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nocturnal Mode'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
        body: nocturnalAsync.when(
          data: (state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ambient Soundscapes',
                    style: darkTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SoundScapeCard(
                          title: 'Deep Rain',
                          icon: '🌧️',
                          isPlaying: state.isPlayingSound && state.activeSoundTrack == 'Deep Rain',
                          onTap: () => ref.read(nocturnalControllerProvider.notifier).toggleSound('Deep Rain'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SoundScapeCard(
                          title: 'White Noise',
                          icon: '📻',
                          isPlaying: state.isPlayingSound && state.activeSoundTrack == 'White Noise',
                          onTap: () => ref.read(nocturnalControllerProvider.notifier).toggleSound('White Noise'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SoundScapeCard(
                          title: 'Binaural',
                          icon: '🎧',
                          isPlaying: state.isPlayingSound && state.activeSoundTrack == 'Binaural',
                          onTap: () => ref.read(nocturnalControllerProvider.notifier).toggleSound('Binaural'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Dream Journal',
                    style: darkTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: dreamController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Record a dream immediately upon waking...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      filled: true,
                      fillColor: darkTheme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkTheme.colorScheme.primary,
                        foregroundColor: darkTheme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (dreamController.text.isNotEmpty) {
                          ref.read(nocturnalControllerProvider.notifier).addDream(dreamController.text);
                          dreamController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Dream safely stored.'),
                              backgroundColor: darkTheme.colorScheme.tertiary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: const Text('Save Dream', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (state.dreams.isNotEmpty) ...[
                    Text(
                      'Past Dreams',
                      style: darkTheme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...state.dreams.map((dream) => DreamCard(dream: dream)).toList(),
                  ]
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
