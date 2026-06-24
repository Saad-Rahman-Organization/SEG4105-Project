import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../models/meal_models.dart';

final mealAnalysisServiceProvider = Provider<MealAnalysisService>(
  (ref) => MealAnalysisService(),
);

class MealAnalysisService {
  MealAnalysisService({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final Uri _endpoint =
      Uri.parse('http://flask-route-saadrahmanwarsi-dev.apps.rm2.thpm.p1.openshiftapps.com/api/analyze-meal');
  final Uuid _uuid = const Uuid();

  Future<MealAnalysis> analyzeMeal({required MealPayload payload}) async {
    final imageFile = File(payload.capture.localPath);
    if (!await imageFile.exists()) {
      throw MealAnalysisException('Image file not found. Please capture the meal again.');
    }

    final request = http.MultipartRequest('POST', _endpoint)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path))
      ..fields['meal_tag'] = _inferMealTag(payload);

    http.StreamedResponse streamed;
    try {
      streamed = await _httpClient.send(request);
    } on SocketException {
      throw MealAnalysisException('No internet connection. Try again when you are online.');
    } catch (error) {
      throw MealAnalysisException('Could not reach the analysis service. $error');
    }

    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode != 200) {
      throw MealAnalysisException(
        'Analysis failed (${streamed.statusCode}). ${body.isEmpty ? 'No response body.' : body}',
      );
    }

    final Map<String, dynamic> decoded = jsonDecode(body) as Map<String, dynamic>;
    return _mapResponse(decoded, payload);
  }

  MealAnalysis _mapResponse(Map<String, dynamic> data, MealPayload payload) {
    final foodsData = (data['foods'] as List?) ?? [];
    final foods = foodsData.map((raw) {
      final map = (raw as Map).cast<String, dynamic>();
      final macrosData = (map['macros'] as Map?)?.cast<String, dynamic>() ?? {};
      final fiber = _parseGrams(macrosData['fiber']);
      final portion = (map['portion_size'] as String?)?.trim();
      final foodName = (map['name'] as String?)?.trim();
      return IdentifiedFood(
        id: _uuid.v4(),
        name: foodName?.isNotEmpty == true ? foodName! : 'Item',
        calories: (map['calories'] as num?)?.round() ?? 0,
        macros: Macros(
          carbs: _parseGrams(macrosData['carbohydrates']),
          protein: _parseGrams(macrosData['protein']),
          fat: _parseGrams(macrosData['fat']),
        ),
        portionSize: portion?.isEmpty == true ? null : portion,
        highlights: [
          if (portion != null && portion.isNotEmpty) 'Portion: $portion',
          if (fiber > 0) 'Fiber: ${_formatGrams(fiber)}',
        ],
      );
    }).toList();

    final ingredients = ((data['ingredients_list'] as List?) ?? [])
        .map(
          (raw) => IngredientPortion(
            name: ((raw as Map)['name'] as String?)?.trim().isNotEmpty ?? false
                ? (raw['name'] as String).trim()
                : 'Ingredient',
            portionSize: ((raw)['portion_size'] as String?)?.trim().isEmpty ?? true
                ? null
                : (raw['portion_size'] as String).trim(),
          ),
        )
        .toList();

    final totalMacrosData = (data['total_macros'] as Map?)?.cast<String, dynamic>() ?? {};
    final macros = Macros(
      carbs: _parseGrams(totalMacrosData['carbohydrates']),
      protein: _parseGrams(totalMacrosData['protein']),
      fat: _parseGrams(totalMacrosData['fat']),
    );
    final totalFiber = _parseGrams(totalMacrosData['fiber']);

    final mealTag = (data['meal_tag'] as String?)?.trim();
    final notes = (data['notes'] as String?)?.trim();

    return MealAnalysis(
      id: _uuid.v4(),
      localId: payload.localId,
      mealTitle: mealTag?.isNotEmpty == true ? mealTag! : 'Meal',
      mealTag: mealTag,
      totalCalories: (data['total_calories'] as num?)?.round() ?? 0,
      confidence: _parseConfidence(data['confidence_level']),
      timestamp: DateTime.tryParse((data['timestamp'] as String?) ?? '') ?? DateTime.now(),
      identifiedFoods: foods,
      macros: macros,
      qualitativeFeedback: notes?.isNotEmpty == true ? notes! : 'No comments returned for this scan.',
      warnings: const [],
      ingredients: ingredients,
      totalFiber: totalFiber,
    );
  }

  double _parseGrams(dynamic raw) {
    if (raw == null) return 0;
    if (raw is num) return raw.toDouble();
    if (raw is String) {
      final match = RegExp(r'([0-9]+(?:\.[0-9]+)?)').firstMatch(raw);
      if (match != null) {
        return double.tryParse(match.group(1)!) ?? 0;
      }
    }
    return 0;
  }

  String _formatGrams(num grams) {
    return grams % 1 == 0 ? '${grams.toInt()}g' : grams.toStringAsFixed(1) + 'g';
  }

  Confidence _parseConfidence(dynamic raw) {
    final value = (raw as String?)?.toLowerCase() ?? '';
    switch (value) {
      case 'high':
        return Confidence.high;
      case 'low':
        return Confidence.low;
      default:
        return Confidence.medium;
    }
  }

  String _inferMealTag(MealPayload payload) {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Breakfast';
    if (hour < 16) return 'Lunch';
    if (hour < 21) return 'Dinner';
    return 'Snack';
  }
}

class MealAnalysisException implements Exception {
  MealAnalysisException(this.message);
  final String message;

  @override
  String toString() => message;
}
