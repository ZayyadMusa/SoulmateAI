import 'package:flutter/material.dart';
import '../../domain/models/voice_profile.dart';

class VoiceProfileCard extends StatelessWidget {
  final VoiceProfile profile;
  final VoidCallback onSelect;

  const VoiceProfileCard({
    super.key,
    required this.profile,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: profile.isSelected 
            ? theme.colorScheme.primary 
            : theme.colorScheme.outlineVariant.withOpacity(0.3),
          width: profile.isSelected ? 2 : 1,
        ),
      ),
      elevation: profile.isSelected ? 4 : 0,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: profile.isSelected
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.record_voice_over_outlined,
                    color: profile.isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (profile.isSelected)
                Icon(Icons.check_circle, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
