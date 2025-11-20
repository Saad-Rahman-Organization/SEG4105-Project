import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

import '../models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile?> fetchProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> clear();
}

class InMemoryProfileRepository implements ProfileRepository {
  UserProfile? _profile;

  @override
  Future<UserProfile?> fetchProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _profile;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    _profile = profile;
  }

  @override
  Future<void> clear() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _profile = null;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => InMemoryProfileRepository(),
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
