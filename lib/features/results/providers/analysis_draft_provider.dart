import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../../../core/models/meal_models.dart';

final analysisDraftProvider = StateProvider<MealAnalysis?>((ref) => null);
