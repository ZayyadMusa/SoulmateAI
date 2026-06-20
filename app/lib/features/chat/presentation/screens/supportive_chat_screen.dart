import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SupportiveChatScreen extends StatefulWidget {
  const SupportiveChatScreen({super.key});

  @override
  State<SupportiveChatScreen> createState() => _SupportiveChatScreenState();
}

class _SupportiveChatScreenState extends State<SupportiveChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  
  late AnimationController _avatarController;
  late Animation<double> _avatarAnimation;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _avatarAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _avatarController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  void _handleSuggestionTap(String text) {
    _textController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.1),
        titleSpacing: 24,
        title: Row(
          children: [
            ScaleTransition(
              scale: _avatarAnimation,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryContainer, AppTheme.primaryFixedDim, AppTheme.secondaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(28),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Soulmate AI',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  // Daily Ritual Nudge
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12), // rounded-xl
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.08),
                          blurRadius: 32,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.water_drop, color: AppTheme.primary, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Daily Ritual',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        color: AppTheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'Did you drink water today?',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppTheme.onSurfaceVariant,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryContainer,
                            foregroundColor: AppTheme.onPrimaryContainer,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                          child: const Text('Check In'),
                        ),
                      ],
                    ),
                  ),

                  // Chat Flow
                  _buildAiMessage('Hey there! How was your day? Tell me about the best part of it.'),
                  const SizedBox(height: 16),
                  _buildUserMessage('It was good! I finally finished that project. But I\'m feeling a bit drained now.'),
                  const SizedBox(height: 16),
                  _buildAiMessage('I\'m so proud of you for finishing that! You deserve a real rest. Have you had enough water today? Maybe a few minutes of quiet would help you recharge.'),
                  const SizedBox(height: 24),

                  // Typing Suggestion Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSuggestionChip('Thank you, I will'),
                        const SizedBox(width: 8),
                        _buildSuggestionChip('I need more water'),
                        const SizedBox(width: 8),
                        _buildSuggestionChip("Let's meditate"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Floating Input Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: AppTheme.background,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: AppTheme.surfaceVariant.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.08),
                      blurRadius: 32,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: AppTheme.onSurfaceVariant),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Tell me what's on your mind...",
                          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: AppTheme.onPrimary, size: 20),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildAiMessage(String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryContainer, AppTheme.primaryFixedDim, AppTheme.secondaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(4), // rounded-bl-none approx
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.08),
                  blurRadius: 32,
                ),
              ],
            ),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32), // padding to ensure max width visually
      ],
    );
  }

  Widget _buildUserMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 32), // padding to ensure max width visually
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(4), // rounded-br-none approx
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String text) {
    return InkWell(
      onTap: () => _handleSuggestionTap(text),
      borderRadius: BorderRadius.circular(9999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.tertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppTheme.tertiary,
          ),
        ),
      ),
    );
  }

}
