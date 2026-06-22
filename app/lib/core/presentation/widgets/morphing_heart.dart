import 'dart:math' as math;
import 'package:flutter/material.dart';

class GlowBackground extends StatefulWidget {
  const GlowBackground({Key? key}) : super(key: key);

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: -80,
              child: Transform.scale(
                scale: _animation.value,
                child: Container(
                  width: 384,
                  height: 384,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.25,
              right: -80,
              child: Transform.scale(
                scale: 2.2 - _animation.value, // Opposite phase
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MorphingHeart extends StatefulWidget {
  final Widget? child;

  const MorphingHeart({Key? key, this.child}) : super(key: key);

  @override
  State<MorphingHeart> createState() => _MorphingHeartState();
}

class _MorphingHeartState extends State<MorphingHeart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        // Interpolate between the CSS values:
        // 60% 40% 30% 70% / 60% 30% 70% 40%  -> 40% 60% 70% 30% / 40% 70% 30% 60%
        final r1 = lerpDouble(60, 40, t);
        final r2 = lerpDouble(40, 60, t);
        final r3 = lerpDouble(30, 70, t);
        final r4 = lerpDouble(70, 30, t);

        final y1 = lerpDouble(60, 40, t);
        final y2 = lerpDouble(30, 70, t);
        final y3 = lerpDouble(70, 30, t);
        final y4 = lerpDouble(40, 60, t);

        return Container(
          width: 192,
          height: 192,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shadows: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
            shape: _MorphShape(r1, r2, r3, r4, y1, y2, y3, y4),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

class _MorphShape extends ShapeBorder {
  final double r1, r2, r3, r4, y1, y2, y3, y4;

  const _MorphShape(this.r1, this.r2, this.r3, this.r4, this.y1, this.y2, this.y3, this.y4);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final w = rect.width;
    final h = rect.height;
    
    // Draw an elliptical bezier approximation
    Path path = Path();
    path.moveTo(w * r1 / 100, 0);
    path.cubicTo(w, 0, w, h * y2 / 100, w, h * y2 / 100); // Approximate
    // A true bezier for border radius isn't strictly required, 
    // a simple path with varying radii points creates the blob.
    
    // For a real blob, creating a custom cubic path around the 4 points:
    path = Path();
    path.moveTo(w * r1 / 100, 0);
    path.cubicTo(w * (r1/100 + 0.2), 0, w, h * (y1/100 - 0.2), w, h * y1 / 100);
    path.cubicTo(w, h * (y1/100 + 0.2), w * (r2/100 + 0.2), h, w * r2 / 100, h);
    path.cubicTo(w * (r2/100 - 0.2), h, 0, h * (y2/100 + 0.2), 0, h * y2 / 100);
    path.cubicTo(0, h * (y2/100 - 0.2), w * (r1/100 - 0.2), 0, w * r1 / 100, 0);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
