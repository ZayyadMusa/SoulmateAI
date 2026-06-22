import 'package:flutter/material.dart';

class SoundScapeCard extends StatelessWidget {
  final String title;
  final String icon;
  final bool isPlaying;
  final VoidCallback onTap;

  const SoundScapeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isPlaying 
              ? theme.colorScheme.primaryContainer.withOpacity(0.3) 
              : theme.colorScheme.surface.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPlaying 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outlineVariant.withOpacity(0.1),
            width: isPlaying ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isPlaying ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
