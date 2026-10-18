import 'package:flutter/material.dart';

/// Animated Blood Drop Emblem with heartbeat pulse animation.
class BloodDropLogo extends StatefulWidget {
  final double size;
  final bool animated;
  final bool showGlow;

  const BloodDropLogo({
    super.key,
    this.size = 80,
    this.animated = true,
    this.showGlow = true,
  });

  @override
  State<BloodDropLogo> createState() => _BloodDropLogoState();
}

class _BloodDropLogoState extends State<BloodDropLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    if (widget.animated) {
      _scaleAnimation = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.0,
            end: 1.08,
          ).chain(CurveTween(curve: Curves.easeOutQuad)),
          weight: 20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.08,
            end: 0.98,
          ).chain(CurveTween(curve: Curves.easeInOutQuad)),
          weight: 20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.98,
            end: 1.04,
          ).chain(CurveTween(curve: Curves.easeOutQuad)),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.04,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeInOutQuad)),
          weight: 45,
        ),
      ]).animate(_controller);

      _glowAnimation = Tween<double>(begin: 0.3, end: 0.65).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
      );

      _controller.repeat();
    } else {
      _scaleAnimation = const AlwaysStoppedAnimation(1.0);
      _glowAnimation = const AlwaysStoppedAnimation(0.4);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size * 1.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: widget.showGlow
                  ? [
                      BoxShadow(
                        color: cs.primary.withValues(
                          alpha: _glowAnimation.value,
                        ),
                        blurRadius: widget.size * 0.45,
                        spreadRadius: widget.size * 0.05,
                      ),
                    ]
                  : null,
            ),
            child: CustomPaint(
              size: Size(widget.size, widget.size * 1.15),
              painter: _BloodDropPainter(
                primaryColor: cs.primary,
                deepColor: cs.primaryContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BloodDropPainter extends CustomPainter {
  final Color primaryColor;
  final Color deepColor;

  _BloodDropPainter({
    required this.primaryColor,
    required this.deepColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final path = Path();
    // Start at top sharp tip of the drop
    path.moveTo(width * 0.5, 0);

    // Right curve down to circular base
    path.cubicTo(
      width * 0.78,
      height * 0.35,
      width,
      height * 0.62,
      width,
      height * 0.75,
    );

    // Bottom arc
    path.arcToPoint(
      Offset(0, height * 0.75),
      radius: Radius.circular(width * 0.5),
      clockwise: true,
    );

    // Left curve back up to tip
    path.cubicTo(
      0,
      height * 0.62,
      width * 0.22,
      height * 0.35,
      width * 0.5,
      0,
    );
    path.close();

    // Drop Linear Gradient
    final rect = Rect.fromLTWH(0, 0, width, height);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFF5252),
        Color(0xFFD32F2F),
        Color(0xFF8E0000),
        // primaryColor.withValues(alpha: 0.9),
        // primaryColor,
        // deepColor,
      ],
      stops: const [0.0, 0.55, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Subtle inner glossy reflection highlight
    final highlightPath = Path();
    highlightPath.moveTo(width * 0.45, height * 0.18);
    highlightPath.cubicTo(
      width * 0.3,
      height * 0.38,
      width * 0.2,
      height * 0.55,
      width * 0.22,
      height * 0.72,
    );
    highlightPath.cubicTo(
      width * 0.16,
      height * 0.55,
      width * 0.25,
      height * 0.35,
      width * 0.45,
      height * 0.18,
    );
    highlightPath.close();

    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.32)
      ..style = PaintingStyle.fill;

    canvas.drawPath(highlightPath, highlightPaint);

    // White medical cross or heartbeat pulse inside the drop
    final crossPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = width * 0.08
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // A sleek mini heartbeat ECG line inside
    final ecgPath = Path();
    final centerY = height * 0.72;
    ecgPath.moveTo(width * 0.28, centerY);
    ecgPath.lineTo(width * 0.40, centerY);
    ecgPath.lineTo(width * 0.46, centerY - height * 0.14);
    ecgPath.lineTo(width * 0.54, centerY + height * 0.10);
    ecgPath.lineTo(width * 0.60, centerY - height * 0.05);
    ecgPath.lineTo(width * 0.63, centerY);
    ecgPath.lineTo(width * 0.72, centerY);

    canvas.drawPath(ecgPath, crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
