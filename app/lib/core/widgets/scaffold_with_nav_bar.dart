import 'dart:ui' as dart_ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BackdropFilter(
                filter: dart_ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 24, top: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.04),
                        blurRadius: 24,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, Icons.auto_awesome, 'Reflect', 0),
                      _buildNavItem(context, Icons.inventory_2_outlined, 'Memory Jar', 1),
                      _buildNavItem(context, Icons.record_voice_over_outlined, 'Soulmate', 2),
                      _buildNavItem(context, Icons.chat_bubble_outline, 'Chat', 3),
                      _buildNavItem(context, Icons.settings, 'Settings', 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => _goBranch(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              icon,
              color: isSelected ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
