import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/meal_models.dart';

final correctionServiceProvider = Provider<CorrectionService>(
  (ref) => CorrectionService(),
);

class CorrectionService {
  CorrectionService({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  final http.Client _client;
  final Uri _endpoint = Uri.parse('https://example.com/api/meal-corrections');

  Future<void> sendCorrection({required MealAnalysis updated}) async {
    final payload = {
      'id': updated.id,
      'meal_title': updated.mealTitle,
      'timestamp': updated.timestamp.toIso8601String(),
      'foods': updated.identifiedFoods
          .map(
            (f) => {
              'name': f.name,
              'calories': f.calories,
              'portion_size': f.portionSize,
            },
          )
          .toList(),
      'ingredients': updated.ingredients
          .map((i) => {
                'name': i.name,
                'portion_size': i.portionSize,
              })
          .toList(),
      'total_calories': updated.totalCalories,
      'notes': updated.qualitativeFeedback,
    };

    try {
      await _client.post(
        _endpoint,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
    } catch (_) {
      // Silently ignore for now; placeholder for future handling.
    }
  }
}
