import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_bubble.dart';

class SupportiveChatScreen extends HookConsumerWidget {
  const SupportiveChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatControllerProvider);
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final theme = Theme.of(context);

    // Auto-scroll to bottom when new messages arrive
    ref.listen(chatControllerProvider, (_, __) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Mock: Generated Draft Email opened.'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: theme.colorScheme.secondary,
                ),
              );
            },
            icon: const Icon(Icons.mail_outline),
            label: const Text('Draft Email'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatAsync.when(
              data: (messages) {
                // messages are sorted newest first. Reverse for rendering top-down.
                final displayMessages = messages.reversed.toList();
                
                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24.0),
                  itemCount: displayMessages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(message: displayMessages[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.05),
                  blurRadius: 24,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: theme.colorScheme.primaryContainer.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          ref.read(chatControllerProvider.notifier).sendMessage(text);
                          textController.clear();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: theme.colorScheme.onPrimary),
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          ref.read(chatControllerProvider.notifier).sendMessage(textController.text);
                          textController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
