import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EmailAssistanceChatScreen extends StatefulWidget {
  const EmailAssistanceChatScreen({super.key});

  @override
  State<EmailAssistanceChatScreen> createState() => _EmailAssistanceChatScreenState();
}

class _EmailAssistanceChatScreenState extends State<EmailAssistanceChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _morphController;
  late Animation<double> _morphRadiusAnimation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _morphRadiusAnimation = Tween<double>(begin: 0.4, end: 0.7).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _morphController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        titleSpacing: 24,
        title: Row(
          children: [
            AnimatedBuilder(
              animation: _morphController,
              builder: (context, child) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryFixedDim, AppTheme.primaryContainer],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40 * _morphRadiusAnimation.value),
                      topRight: Radius.circular(40 * (1 - _morphRadiusAnimation.value)),
                      bottomLeft: Radius.circular(40 * 0.3),
                      bottomRight: Radius.circular(40 * 0.7),
                    ),
                  ),
                  child: const Icon(Icons.face, color: Colors.white, size: 20),
                );
              },
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
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Main Content Canvas (Chat)
          ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 180),
            children: [
              // Message 1: AI (Email Context)
              _buildAiMessage(
                time: '10:45 AM',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mail, color: AppTheme.primary, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project Update',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppTheme.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Sarah • 10:24 AM',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'I noticed you have an unread email from Sarah about the project update. Would you like me to help you draft a warm reply?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // Message 2: User
              _buildUserMessage(
                text: "Yes please! Tell her I can't make it today but I'll definitely be there tomorrow.",
                time: '10:46 AM',
              ),

              // Message 3: AI (Drafting)
              _buildAiMessage(
                time: '10:46 AM',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Got it. How does this sound?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.05),
                        border: const Border(left: BorderSide(color: AppTheme.primary, width: 4)),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        '"Hi Sarah, so sorry I can\'t make it today. I\'m really looking forward to catching up and I\'ll definitely be there tomorrow to dive in with you!"',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Message 4: User (Confirmation)
              _buildUserMessage(
                text: "That's perfect. Send it.",
                time: '10:47 AM',
              ),

              // Message 5: AI (Final Confirmation)
              _buildAiMessage(
                time: '10:47 AM',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppTheme.tertiary, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          'Email Sent',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sent! One less thing for you to worry about today. ✨',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Contextual FAB
          Positioned(
            bottom: 120,
            right: 24,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              child: const Icon(Icons.add, size: 28),
            ),
          ),

          // Chat Input Area
          Positioned(
            bottom: 88,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.surface.withOpacity(0.9),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.outline,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppTheme.primary),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.chat_bubble, 'Chat', true),
            _buildNavItem(Icons.auto_awesome_motion, 'Rituals', false),
            _buildNavItem(Icons.auto_stories, 'Reflection', false),
            _buildNavItem(Icons.calendar_today, 'Calendar', false),
          ],
        ),
      ),
    );
  }

  Widget _buildAiMessage({required Widget child, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(8),
              ),
              border: Border.all(color: AppTheme.surfaceContainer),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              time,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: AppTheme.outlineVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage({required String text, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              time,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: AppTheme.outlineVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: isActive
            ? BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: isActive ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
