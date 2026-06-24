import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NutriGradientButton extends HookConsumerWidget {
  const NutriGradientButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.isBusy = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isBusy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final basePrimary = isDark ? theme.colorScheme.primaryContainer : theme.colorScheme.primary;
    final onBasePrimary = isDark ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onPrimary;
    final pressed = useState(false);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: pressed.value ? 0.95 : 1),
      duration: const Duration(milliseconds: 160),
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              basePrimary.withValues(alpha: isDark ? 0.88 : 1),
              basePrimary.withValues(alpha: isDark ? 0.72 : 0.75),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: basePrimary.withValues(alpha: isDark ? 0.12 : 0.24),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onHighlightChanged: (value) => pressed.value = value,
            onTap: isBusy ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: onBasePrimary),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: onBasePrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isBusy) ...[
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        onBasePrimary,
                      ),
                    ),
                  ),
                ],
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
