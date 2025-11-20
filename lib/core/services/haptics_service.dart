import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HapticsService {
  Future<void> lightImpact() => HapticFeedback.lightImpact();
  Future<void> mediumImpact() => HapticFeedback.mediumImpact();
  Future<void> selection() => HapticFeedback.selectionClick();
}

final hapticsServiceProvider = Provider<HapticsService>((ref) {
  return HapticsService();
});
