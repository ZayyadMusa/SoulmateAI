import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/memory_controller.dart';
import '../widgets/memory_card.dart';
import '../widgets/search_bar.dart';

class MemoryJarScreen extends HookConsumerWidget {
  const MemoryJarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoriesAsync = ref.watch(memoryControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Jar'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            MemorySearchBar(
              onChanged: (query) {
                ref.read(memoryControllerProvider.notifier).search(query);
              },
            ),
            const SizedBox(height: 32),
            Expanded(
              child: memoriesAsync.when(
                data: (memories) {
                  if (memories.isEmpty) {
                    return Center(
                      child: Text(
                        'Your jar is empty.\nSave some beautiful moments.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: memories.length,
                    itemBuilder: (context, index) {
                      return MemoryCard(memory: memories[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add a mock memory to demonstrate functionality
          ref.read(memoryControllerProvider.notifier).addMemory(
            'A Peaceful Morning',
            'I sat by the window with my coffee and just watched the rain. It was incredibly calming.',
            ['peace', 'rain', 'coffee'],
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Memory'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
    );
  }
}
