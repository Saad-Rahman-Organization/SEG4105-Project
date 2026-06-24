import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile?> fetchProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> clear();
}

class LocalProfileRepository implements ProfileRepository {
  LocalProfileRepository(this._prefs);

  static const _profileKey = 'profile_v1';
  final SharedPreferences _prefs;

  @override
  Future<UserProfile?> fetchProfile() async {
    final stored = _prefs.getString(_profileKey);
    if (stored == null) return null;
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      return UserProfile.fromJson(map);
    } catch (_) {
      // If parsing fails, clear corrupt data to avoid blocking onboarding.
      await clear();
      return null;
    }
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await _prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(_profileKey);
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => throw UnimplementedError('ProfileRepository provider not initialized'),
);

class ProfileController extends StateNotifier<UserProfile?> {
  ProfileController(this._repository) : super(null) {
    _load();
  }

  final ProfileRepository _repository;
  final _uuid = const Uuid();

  Future<void> _load() async {
    final profile = await _repository.fetchProfile();
    state = profile;
  }

  Future<void> completeOnboarding({
    required String? name,
    required double heightValue,
    required HeightUnit heightUnit,
    required double weightValue,
    required WeightUnit weightUnit,
    required ActivityLevel activityLevel,
    int? dailyCalorieGoal,
  }) async {
    final profile = UserProfile(
      id: _uuid.v4(),
      name: name?.trim().isEmpty ?? true ? null : name?.trim(),
      heightValue: heightValue,
      heightUnit: heightUnit,
      weightValue: weightValue,
      weightUnit: weightUnit,
      activityLevel: activityLevel,
      dailyCalorieGoal: dailyCalorieGoal,
      onboardingCompleted: true,
    );
    await _repository.saveProfile(profile);
    state = profile;
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _repository.saveProfile(profile);
    state = profile;
  }

  Future<void> clear() async {
    await _repository.clear();
    state = null;
  }
}

final profileProvider =
    StateNotifierProvider<ProfileController, UserProfile?>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileController(repository);
});
