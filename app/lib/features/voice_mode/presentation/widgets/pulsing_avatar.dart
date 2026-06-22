import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../controllers/voice_session_controller.dart';

class PulsingAvatar extends HookWidget {
  final SessionState sessionState;

  const PulsingAvatar({super.key, required this.sessionState});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      if (sessionState == SessionState.listening || sessionState == SessionState.speaking) {
        animationController.duration = const Duration(milliseconds: 1500);
        animationController.repeat(reverse: true);
      } else if (sessionState == SessionState.processing) {
        animationController.duration = const Duration(milliseconds: 500);
        animationController.repeat(reverse: true);
      } else {
        animationController.stop();
        animationController.animateTo(0);
      }
      return null;
    }, [sessionState]);

    final theme = Theme.of(context);
    final scale = useAnimation(Tween(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    ));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                theme.colorScheme.primaryContainer.withOpacity(0.8),
                theme.colorScheme.primaryContainer.withOpacity(0.0),
              ],
            ),
            boxShadow: [
              if (sessionState != SessionState.idle)
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  blurRadius: 60 * scale,
                  spreadRadius: 20 * scale,
                )
            ],
          ),
          child: Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
              child: sessionState == SessionState.idle
                  ? Icon(Icons.mic_none, size: 48, color: theme.colorScheme.onPrimary)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
