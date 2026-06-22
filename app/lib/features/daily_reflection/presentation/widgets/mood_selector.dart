import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final String selectedMood;
  final ValueChanged<String> onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final moods = ['Happy', 'Calm', 'Stressed', 'Anxious', 'Sad'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: moods.map((mood) {
        final isSelected = mood == selectedMood;
        final theme = Theme.of(context);
        
        return ChoiceChip(
          label: Text(mood),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) onMoodSelected(mood);
          },
          selectedColor: theme.colorScheme.secondary.withOpacity(0.1),
          backgroundColor: theme.colorScheme.surface,
          labelStyle: TextStyle(
            color: isSelected 
                ? theme.colorScheme.secondary
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          side: BorderSide(
            color: isSelected ? Colors.transparent : theme.colorScheme.outlineVariant.withOpacity(0.5),
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      }).toList(),
    );
  }
}
