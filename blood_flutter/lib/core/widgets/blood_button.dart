import 'package:flutter/material.dart';

enum BloodButtonStyle { primary, secondary, outline, text }

/// Premium animated button with micro-interactions, gradients, and loading states.
class BloodButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final BloodButtonStyle style;
  final IconData? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;

  const BloodButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.style = BloodButtonStyle.primary,
    this.icon,
    this.width,
    this.height = 54,
    this.borderRadius = 16,
    this.backgroundColor,
  });

  @override
  State<BloodButton> createState() => _BloodButtonState();
}

class _BloodButtonState extends State<BloodButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.04,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null && !widget.isLoading;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    BoxDecoration decoration;
    Color textColor;

    switch (widget.style) {
      case BloodButtonStyle.primary:
        final btnColor = widget.backgroundColor ?? cs.primary;
        decoration = BoxDecoration(
          gradient: isEnabled && widget.backgroundColor == null
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cs.primary,
                    isDark
                        ? cs.primaryContainer
                        : cs.primary.withValues(alpha: 0.85),
                  ],
                )
              : null,
          color: isEnabled ? btnColor : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: btnColor.withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        );
        textColor = isEnabled
            ? cs.onPrimary
            : cs.onSurfaceVariant.withValues(alpha: 0.6);
        break;

      case BloodButtonStyle.secondary:
        decoration = BoxDecoration(
          color: isDark
              ? cs.surfaceContainerHighest
              : cs.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
        textColor = cs.onSurface;
        break;

      case BloodButtonStyle.outline:
        decoration = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isEnabled ? cs.primary : cs.outlineVariant,
            width: 1.5,
          ),
        );
        textColor = isEnabled ? cs.primary : cs.onSurfaceVariant;
        break;

      case BloodButtonStyle.text:
        decoration = const BoxDecoration(color: Colors.transparent);
        textColor = isEnabled ? cs.primary : cs.onSurfaceVariant;
        break;
    }

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width ?? double.infinity,
            height: widget.height,
            decoration: decoration,
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, color: textColor, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
