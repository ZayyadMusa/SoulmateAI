import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/reflection_controller.dart';
import '../widgets/mood_selector.dart';

class DailyReflectionScreen extends HookConsumerWidget {
  const DailyReflectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMood = useState<String>('Calm');
    final contentController = useTextEditingController();
    final theme = Theme.of(context);

    // Watch the state just to show how many reflections we have (optional)
    final reflectionsAsync = ref.watch(reflectionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Check-in'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling?',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            MoodSelector(
              selectedMood: selectedMood.value,
              onMoodSelected: (mood) => selectedMood.value = mood,
            ),
            const SizedBox(height: 40),
            Text(
              'What\'s on your mind?',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.04),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: TextField(
                controller: contentController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Write your thoughts here... Let it all out.',
                  hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.4)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(24),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (contentController.text.isNotEmpty) {
                    ref.read(reflectionControllerProvider.notifier)
                       .addReflection(selectedMood.value, contentController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Reflection saved peacefully.'),
                        backgroundColor: theme.colorScheme.tertiary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                    contentController.clear();
                  }
                },
                child: const Text(
                  'Save Reflection',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            reflectionsAsync.when(
              data: (reflections) => Center(
                child: Text(
                  'You have ${reflections.length} reflections saved.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
