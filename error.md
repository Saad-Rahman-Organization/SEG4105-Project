TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/nutri_snap
$ flutter clean
Deleting build...                                                  750ms
Deleting .dart_tool...                                              62ms
Deleting Generated.xcconfig...                                       0ms
Deleting flutter_export_environment.sh...                            0ms
Deleting ephemeral...                                                0ms
Deleting ephemeral...                                                0ms
Deleting .flutter-plugins-dependencies...                            0ms
Deleting .flutter-plugins...                                         0ms

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/nutri_snap
$ flutter pub get
Resolving dependencies...
Downloading packages...
  _fe_analyzer_shared 76.0.0 (92.0.0 available)
  analyzer 6.11.0 (9.0.0 available)
  async 2.12.0 (2.13.0 available)
  build 2.5.4 (4.0.3 available)
  build_config 1.1.2 (1.2.0 available)
  build_resolvers 2.5.4 (3.0.4 available)
  build_runner 2.5.4 (2.10.4 available)
  build_runner_core 9.1.2 (9.3.2 available)
  camera 0.11.2+1 (0.11.3 available)
  camera_android_camerax 0.6.19+1 (0.6.24+2 available)
  camera_avfoundation 0.9.21+2 (0.9.22+6 available)
  camera_web 0.3.5 (0.3.5+1 available)
  characters 1.4.0 (1.4.1 available)
  checked_yaml 2.0.3 (2.0.4 available)
  cross_file 0.3.5 (0.3.5+1 available)
  dart_style 2.3.8 (3.1.3 available)
  fake_async 1.3.2 (1.3.3 available)
  file_selector_linux 0.9.3+2 (0.9.3+3 available)
  file_selector_macos 0.9.4+4 (0.9.4+6 available)
  file_selector_windows 0.9.3+4 (0.9.3+5 available)
  fl_chart 1.1.0 (1.1.1 available)
  flutter_hooks 0.21.2 (0.21.3+1 available)
  flutter_lints 5.0.0 (6.0.0 available)
  flutter_plugin_android_lifecycle 2.0.31 (2.0.32 available)
  freezed 3.0.0-0.0.dev (3.2.3 available)
  image_picker_android 0.8.13+1 (0.8.13+9 available)
  image_picker_for_web 3.1.0 (3.1.1 available)
  image_picker_ios 0.8.13 (0.8.13+2 available)
  image_picker_macos 0.2.2 (0.2.2+1 available)
  json_serializable 6.9.0 (6.11.2 available)
  leak_tracker 10.0.8 (11.0.2 available)
  leak_tracker_flutter_testing 3.0.9 (3.0.10 available)
  leak_tracker_testing 3.0.1 (3.0.2 available)
  lints 5.1.1 (6.0.0 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.17.0 available)
  path_provider_android 2.2.19 (2.2.21 available)
  path_provider_foundation 2.4.2 (2.5.0 available)
  petitparser 6.1.0 (7.0.1 available)
  shared_preferences_android 2.4.13 (2.4.16 available)
  shared_preferences_foundation 2.5.4 (2.5.6 available)
  source_gen 1.5.0 (4.1.1 available)
  source_helper 1.3.5 (1.3.9 available)
  sqflite_android 2.4.1 (2.4.2+2 available)
  sqflite_common 2.5.5 (2.5.6 available)
  synchronized 3.3.1 (3.4.0 available)
  test 1.25.15 (1.27.0 available)
  test_api 0.7.4 (0.7.8 available)
  test_core 0.6.8 (0.6.13 available)
  vector_math 2.1.4 (2.2.0 available)
  vm_service 14.3.1 (15.0.2 available)
  win32 5.13.0 (5.15.0 available)
  xml 6.5.0 (6.6.1 available)
Got dependencies!
53 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/nutri_snap
$ flutter run -d emulator
Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...
Warning: The plugin fluttertoast requires Android SDK version 36 or higher.
For more information about build configuration, see https://flutter.dev/to/review-gradle-config.
Your project is configured to compile against Android SDK 35, but the following plugin(s) require to be compiled against a higher Android SDK version:
- fluttertoast compiles against Android SDK 36
Fix this issue by compiling against the highest Android SDK version (they are backward compatible).
Add the following to C:\Users\crims\Documents\0A01_Personal\1B02_Development\1C01_Local\1D00_Projects\NutriSnap\nutri_snap\android\app\build.gradle.kts:

    android {
        compileSdk = 36
        ...
    }

Your project is configured with Android NDK 26.3.11579264, but the following plugin(s) depend on a different Android NDK version:
- camera_android_camerax requires Android NDK 27.0.12077973
- connectivity_plus requires Android NDK 27.0.12077973
- flutter_plugin_android_lifecycle requires Android NDK 27.0.12077973
- fluttertoast requires Android NDK 27.0.12077973
- image_picker_android requires Android NDK 27.0.12077973
- package_info_plus requires Android NDK 27.0.12077973
- path_provider_android requires Android NDK 27.0.12077973
- permission_handler_android requires Android NDK 27.0.12077973
- shared_preferences_android requires Android NDK 27.0.12077973
- sqflite_android requires Android NDK 27.0.12077973
Fix this issue by using the highest Android NDK version (they are backward compatible).
Add the following to C:\Users\crims\Documents\0A01_Personal\1B02_Development\1C01_Local\1D00_Projects\NutriSnap\nutri_snap\android\app\build.gradle.kts:

    android {
        ndkVersion = "27.0.12077973"
        ...
    }

Checking the license for package Android SDK Platform 36 in C:\Users\crims\AppData\Local\Android\Sdk\licenses
License for package Android SDK Platform 36 accepted.
Preparing "Install Android SDK Platform 36 (revision 2)".
"Install Android SDK Platform 36 (revision 2)" ready.
Installing Android SDK Platform 36 in C:\Users\crims\AppData\Local\Android\Sdk\platforms\android-36
"Install Android SDK Platform 36 (revision 2)" complete.
"Install Android SDK Platform 36 (revision 2)" finished.
lib/core/models/app_preferences.dart:3:6: Error: Error when reading 'lib/core/models/app_preferences.freezed.dart': The system cannot find the file specified.

part 'app_preferences.freezed.dart';
     ^
lib/core/models/app_preferences.dart:4:6: Error: Error when reading 'lib/core/models/app_preferences.g.dart': The system cannot find the file specified.

part 'app_preferences.g.dart';
     ^
lib/core/models/user_profile.dart:3:6: Error: Error when reading 'lib/core/models/user_profile.freezed.dart': The system cannot find the file specified.

part 'user_profile.freezed.dart';
     ^
lib/core/models/user_profile.dart:4:6: Error: Error when reading 'lib/core/models/user_profile.g.dart': The system cannot find the file specified.

part 'user_profile.g.dart';
     ^
lib/core/models/meal_models.dart:5:6: Error: Error when reading 'lib/core/models/meal_models.freezed.dart': The system cannot find the file specified.

part 'meal_models.freezed.dart';
     ^
lib/core/models/meal_models.dart:6:6: Error: Error when reading 'lib/core/models/meal_models.g.dart': The system cannot find the file specified.

part 'meal_models.g.dart';
     ^
lib/core/models/app_preferences.dart:3:6: Error: Can't use 'lib/core/models/app_preferences.freezed.dart' as a part, because it has no 'part of' declaration.
part 'app_preferences.freezed.dart';
     ^
lib/core/models/app_preferences.dart:4:6: Error: Can't use 'lib/core/models/app_preferences.g.dart' as a part, because it has no 'part of' declaration.
part 'app_preferences.g.dart';
     ^
lib/core/models/user_profile.dart:3:6: Error: Can't use 'lib/core/models/user_profile.freezed.dart' as a part, because it has no 'part of' declaration.
part 'user_profile.freezed.dart';
     ^
lib/core/models/user_profile.dart:4:6: Error: Can't use 'lib/core/models/user_profile.g.dart' as a part, because it has no 'part of' declaration.
part 'user_profile.g.dart';
     ^
lib/core/models/meal_models.dart:5:6: Error: Can't use 'lib/core/models/meal_models.freezed.dart' as a part, because it has no 'part of' declaration.
part 'meal_models.freezed.dart';
     ^
lib/core/models/meal_models.dart:6:6: Error: Can't use 'lib/core/models/meal_models.g.dart' as a part, because it has no 'part of' declaration.
part 'meal_models.g.dart';
     ^
lib/app/bootstrap.dart:14:5: Error: Type 'ProviderBase' not found.
    ProviderBase<Object?> provider,
    ^^^^^^^^^^^^
lib/core/data/preferences_repository.dart:34:37: Error: Type 'StateNotifier' not found.
class PreferencesController extends StateNotifier<AppPreferences> {
                                    ^^^^^^^^^^^^^
lib/core/models/app_preferences.dart:28:27: Error: Type '_$AppPreferences' not found.
class AppPreferences with _$AppPreferences {
                          ^^^^^^^^^^^^^^^^
lib/core/data/profile_repository.dart:38:33: Error: Type 'StateNotifier' not found.
class ProfileController extends StateNotifier<UserProfile?> {
                                ^^^^^^^^^^^^^
lib/core/models/user_profile.dart:66:24: Error: Type '_$UserProfile' not found.
class UserProfile with _$UserProfile {
                       ^^^^^^^^^^^^^
lib/core/models/meal_models.dart:11:24: Error: Type '_$CaptureInfo' not found.
class CaptureInfo with _$CaptureInfo {
                       ^^^^^^^^^^^^^
lib/core/models/meal_models.dart:23:28: Error: Type '_$MealPreferences' not found.
class MealPreferences with _$MealPreferences {
                           ^^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:34:19: Error: Type '_$Macros' not found.
class Macros with _$Macros {
                  ^^^^^^^^
lib/core/models/meal_models.dart:49:27: Error: Type '_$IdentifiedFood' not found.
class IdentifiedFood with _$IdentifiedFood {
                          ^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:64:25: Error: Type '_$MealAnalysis' not found.
class MealAnalysis with _$MealAnalysis {
                        ^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:82:24: Error: Type '_$MealPayload' not found.
class MealPayload with _$MealPayload {
                       ^^^^^^^^^^^^^
lib/core/data/history_repository.dart:135:33: Error: Type 'StateNotifier' not found.
class HistoryController extends StateNotifier<HistoryState> {
                                ^^^^^^^^^^^^^
lib/core/services/connectivity_service.dart:6:38: Error: Type 'StateNotifier' not found.
class ConnectivityController extends StateNotifier<bool> {
                                     ^^^^^^^^^^^^^
lib/app/bootstrap.dart:9:7: Error: The type 'AppProviderObserver' must be 'base', 'final' or 'sealed' because the supertype 'ProviderObserver' is 'base'.
Try adding 'base', 'final', or 'sealed' to the type.
class AppProviderObserver extends ProviderObserver {
      ^
lib/core/models/app_preferences.dart:28:7: Error: The type '_$AppPreferences' can't be mixed in.
class AppPreferences with _$AppPreferences {
      ^
lib/core/models/user_profile.dart:66:7: Error: The type '_$UserProfile' can't be mixed in.
class UserProfile with _$UserProfile {
      ^
lib/core/models/meal_models.dart:11:7: Error: The type '_$CaptureInfo' can't be mixed in.
class CaptureInfo with _$CaptureInfo {
      ^
lib/core/models/meal_models.dart:23:7: Error: The type '_$MealPreferences' can't be mixed in.
class MealPreferences with _$MealPreferences {
      ^
lib/core/models/meal_models.dart:34:7: Error: The type '_$Macros' can't be mixed in.
class Macros with _$Macros {
      ^
lib/core/models/meal_models.dart:49:7: Error: The type '_$IdentifiedFood' can't be mixed in.
class IdentifiedFood with _$IdentifiedFood {
      ^
lib/core/models/meal_models.dart:64:7: Error: The type '_$MealAnalysis' can't be mixed in.
class MealAnalysis with _$MealAnalysis {
      ^
lib/core/models/meal_models.dart:82:7: Error: The type '_$MealPayload' can't be mixed in.
class MealPayload with _$MealPayload {
      ^
lib/core/models/app_preferences.dart:32:8: Error: Couldn't find constructor '_AppPreferences'.
  }) = _AppPreferences;
       ^
lib/core/models/app_preferences.dart:32:8: Error: Redirection constructor target not found: '_AppPreferences'
  }) = _AppPreferences;
       ^
lib/core/models/user_profile.dart:77:8: Error: Couldn't find constructor '_UserProfile'.
  }) = _UserProfile;
       ^
lib/core/models/user_profile.dart:77:8: Error: Redirection constructor target not found: '_UserProfile'
  }) = _UserProfile;
       ^
lib/core/models/meal_models.dart:17:8: Error: Couldn't find constructor '_CaptureInfo'.
  }) = _CaptureInfo;
       ^
lib/core/models/meal_models.dart:17:8: Error: Redirection constructor target not found: '_CaptureInfo'
  }) = _CaptureInfo;
       ^
lib/core/models/meal_models.dart:28:8: Error: Couldn't find constructor '_MealPreferences'.
  }) = _MealPreferences;
       ^
lib/core/models/meal_models.dart:28:8: Error: Redirection constructor target not found: '_MealPreferences'
  }) = _MealPreferences;
       ^
lib/core/models/meal_models.dart:39:8: Error: Couldn't find constructor '_Macros'.
  }) = _Macros;
       ^
lib/core/models/meal_models.dart:39:8: Error: Redirection constructor target not found: '_Macros'
  }) = _Macros;
       ^
lib/core/models/meal_models.dart:58:8: Error: Couldn't find constructor '_IdentifiedFood'.
  }) = _IdentifiedFood;
       ^
lib/core/models/meal_models.dart:58:8: Error: Redirection constructor target not found: '_IdentifiedFood'
  }) = _IdentifiedFood;
       ^
lib/core/models/meal_models.dart:76:8: Error: Couldn't find constructor '_MealAnalysis'.
  }) = _MealAnalysis;
       ^
lib/core/models/meal_models.dart:76:8: Error: Redirection constructor target not found: '_MealAnalysis'
  }) = _MealAnalysis;
       ^
lib/core/models/meal_models.dart:88:8: Error: Couldn't find constructor '_MealPayload'.
  }) = _MealPayload;
       ^
lib/core/models/meal_models.dart:88:8: Error: Redirection constructor target not found: '_MealPayload'
  }) = _MealPayload;
       ^
lib/core/data/preferences_repository.dart:58:5: Error: Method not found: 'StateNotifierProvider'.
    StateNotifierProvider<PreferencesController, AppPreferences>((ref) {
    ^^^^^^^^^^^^^^^^^^^^^
lib/core/data/profile_repository.dart:87:5: Error: Method not found: 'StateNotifierProvider'.
    StateNotifierProvider<ProfileController, UserProfile?>((ref) {
    ^^^^^^^^^^^^^^^^^^^^^
lib/features/results/providers/analysis_draft_provider.dart:5:31: Error: Method not found: 'StateProvider'.
final analysisDraftProvider = StateProvider<MealAnalysis?>((ref) => null);
                              ^^^^^^^^^^^^^
lib/core/data/history_repository.dart:189:5: Error: Method not found: 'StateNotifierProvider'.
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
    ^^^^^^^^^^^^^^^^^^^^^
lib/features/camera/providers/capture_providers.dart:5:32: Error: Method not found: 'StateProvider'.
final capturePayloadProvider = StateProvider<MealPayload?>((ref) => null);
                               ^^^^^^^^^^^^^
lib/core/services/connectivity_service.dart:31:5: Error: Method not found: 'StateNotifierProvider'.
    StateNotifierProvider<ConnectivityController, bool>((ref) {
    ^^^^^^^^^^^^^^^^^^^^^
lib/app/bootstrap.dart:13:8: Error: The method 'AppProviderObserver.didUpdateProvider' has more required arguments than those of overridden method 'ProviderObserver.didUpdateProvider'.
  void didUpdateProvider(
       ^
../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/riverpod-3.0.3/lib/src/core/provider_container.dart:1246:8: Context: This is the overridden method ('didUpdateProvider').
  void didUpdateProvider(
       ^
lib/app/bootstrap.dart:14:5: Error: 'ProviderBase' isn't a type.
    ProviderBase<Object?> provider,
    ^^^^^^^^^^^^
lib/core/data/preferences_repository.dart:35:50: Error: Too many positional arguments: 0 allowed, but 1 found.
Try removing the extra positional arguments.
  PreferencesController(this._repository) : super(const AppPreferences(theme: AppTheme.system, units: UnitsPreference.metric)) {
                                                 ^
lib/core/data/preferences_repository.dart:43:5: Error: The setter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = stored;
    ^^^^^
lib/core/data/preferences_repository.dart:47:13: Error: The getter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(theme: theme);
            ^^^^^
lib/core/data/preferences_repository.dart:47:5: Error: The setter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(theme: theme);
    ^^^^^
lib/core/data/preferences_repository.dart:48:28: Error: The getter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    await _repository.save(state);
                           ^^^^^
lib/core/data/preferences_repository.dart:52:13: Error: The getter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(units: units);
            ^^^^^
lib/core/data/preferences_repository.dart:52:5: Error: The setter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(units: units);
    ^^^^^
lib/core/data/preferences_repository.dart:53:28: Error: The getter 'state' isn't defined for the class 'PreferencesController'.
 - 'PreferencesController' is from 'package:nutri_snap/core/data/preferences_repository.dart' ('lib/core/data/preferences_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    await _repository.save(state);
                           ^^^^^
lib/core/models/app_preferences.dart:36:65: Error: Method not found: '_$AppPreferencesFromJson'.
  factory AppPreferences.fromJson(Map<String, dynamic> json) => _$AppPreferencesFromJson(json);
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^
lib/core/data/profile_repository.dart:39:46: Error: Too many positional arguments: 0 allowed, but 1 found.
Try removing the extra positional arguments.
  ProfileController(this._repository) : super(null) {
                                             ^
lib/core/data/profile_repository.dart:48:5: Error: The setter 'state' isn't defined for the class 'ProfileController'.
 - 'ProfileController' is from 'package:nutri_snap/core/data/profile_repository.dart' ('lib/core/data/profile_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = profile;
    ^^^^^
lib/core/data/profile_repository.dart:72:5: Error: The setter 'state' isn't defined for the class 'ProfileController'.
 - 'ProfileController' is from 'package:nutri_snap/core/data/profile_repository.dart' ('lib/core/data/profile_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = profile;
    ^^^^^
lib/core/data/profile_repository.dart:77:5: Error: The setter 'state' isn't defined for the class 'ProfileController'.
 - 'ProfileController' is from 'package:nutri_snap/core/data/profile_repository.dart' ('lib/core/data/profile_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = profile;
    ^^^^^
lib/core/data/profile_repository.dart:82:5: Error: The setter 'state' isn't defined for the class 'ProfileController'.
 - 'ProfileController' is from 'package:nutri_snap/core/data/profile_repository.dart' ('lib/core/data/profile_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = null;
    ^^^^^
lib/core/models/user_profile.dart:81:62: Error: Method not found: '_$UserProfileFromJson'.
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
                                                             ^^^^^^^^^^^^^^^^^^^^^
lib/core/models/user_profile.dart:83:32: Error: The getter 'heightUnit' isn't defined for the class 'UserProfile'.
 - 'UserProfile' is from 'package:nutri_snap/core/models/user_profile.dart' ('lib/core/models/user_profile.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'heightUnit'.
  double get heightInMeters => heightUnit.toCentimeters(heightValue) / 100;
                               ^^^^^^^^^^
lib/core/models/user_profile.dart:83:57: Error: The getter 'heightValue' isn't defined for the class 'UserProfile'.
 - 'UserProfile' is from 'package:nutri_snap/core/models/user_profile.dart' ('lib/core/models/user_profile.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'heightValue'.
  double get heightInMeters => heightUnit.toCentimeters(heightValue) / 100;
                                                        ^^^^^^^^^^^
lib/core/models/user_profile.dart:85:35: Error: The getter 'weightUnit' isn't defined for the class 'UserProfile'.
 - 'UserProfile' is from 'package:nutri_snap/core/models/user_profile.dart' ('lib/core/models/user_profile.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'weightUnit'.
  double get weightInKilograms => weightUnit.toKilograms(weightValue);
                                  ^^^^^^^^^^
lib/core/models/user_profile.dart:85:58: Error: The getter 'weightValue' isn't defined for the class 'UserProfile'.
 - 'UserProfile' is from 'package:nutri_snap/core/models/user_profile.dart' ('lib/core/models/user_profile.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'weightValue'.
  double get weightInKilograms => weightUnit.toKilograms(weightValue);
                                                         ^^^^^^^^^^^
lib/features/processing/presentation/processing_screen.dart:45:37: Error: The method 'copyWith' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing method, or defining a method named 'copyWith'.
          final analysis = template.copyWith(
                                    ^^^^^^^^
lib/features/results/presentation/results_screen.dart:61:70: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
    final isDraft = ref.watch(analysisDraftProvider)?.id == analysis.id;
                                                                     ^^
lib/features/results/presentation/results_screen.dart:86:58: Error: The getter 'macros' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'macros'.
                        MacroDonutChart(macros: analysis.macros),
                                                         ^^^^^^
lib/features/results/presentation/results_screen.dart:100:37: Error: The getter 'identifiedFoods' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'identifiedFoods'.
                        ...analysis.identifiedFoods.map(
                                    ^^^^^^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:123:36: Error: The getter 'qualitativeFeedback' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'qualitativeFeedback'.
                          analysis.qualitativeFeedback,
                                   ^^^^^^^^^^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:127:37: Error: The getter 'warnings' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'warnings'.
                        ...analysis.warnings.map(
                                    ^^^^^^^^
lib/features/results/presentation/results_screen.dart:182:25: Error: The getter 'name' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'name'.
              Text(food.name, style: Theme.of(context).textTheme.headlineSmall),
                        ^^^^
lib/features/results/presentation/results_screen.dart:184:28: Error: The getter 'calories' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'calories'.
              Text('${food.calories} kcal'),
                           ^^^^^^^^
lib/features/results/presentation/results_screen.dart:188:37: Error: The getter 'macros' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'macros'.
              Text('Protein: ${food.macros.protein}g'),
                                    ^^^^^^
lib/features/results/presentation/results_screen.dart:189:35: Error: The getter 'macros' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'macros'.
              Text('Carbs: ${food.macros.carbs}g'),
                                  ^^^^^^
lib/features/results/presentation/results_screen.dart:190:33: Error: The getter 'macros' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'macros'.
              Text('Fat: ${food.macros.fat}g'),
                                ^^^^^^
lib/features/results/presentation/results_screen.dart:192:24: Error: The getter 'highlights' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'highlights'.
              if (food.highlights != null)
                       ^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:195:34: Error: The getter 'highlights' isn't defined for the class 'IdentifiedFood'.
 - 'IdentifiedFood' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'highlights'.
                  children: food.highlights!
                                 ^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:220:27: Error: The getter 'mealTitle' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'mealTitle'.
            Text(analysis.mealTitle, style: Theme.of(context).textTheme.headlineSmall),
                          ^^^^^^^^^
lib/features/results/presentation/results_screen.dart:225:31: Error: The getter 'totalCalories' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'totalCalories'.
                  '${analysis.totalCalories} kcal',
                              ^^^^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:230:43: Error: The getter 'confidence' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'confidence'.
                  label: Text('${analysis.confidence.name} confidence'),
                                          ^^^^^^^^^^
lib/features/results/presentation/results_screen.dart:237:39: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
              'Captured at ${analysis.timestamp.hour.toString().padLeft(2, '0')}:${analysis.timestamp.minute.toString().padLeft(2, '0')}',
                                      ^^^^^^^^^
lib/features/results/presentation/results_screen.dart:237:93: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
              'Captured at ${analysis.timestamp.hour.toString().padLeft(2, '0')}:${analysis.timestamp.minute.toString().padLeft(2, '0')}',
                                                                                          ^^^^^^^^^
lib/core/models/meal_models.dart:19:62: Error: Method not found: '_$CaptureInfoFromJson'.
  factory CaptureInfo.fromJson(Map<String, dynamic> json) => _$CaptureInfoFromJson(json);
                                                             ^^^^^^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:30:66: Error: Method not found: '_$MealPreferencesFromJson'.
  factory MealPreferences.fromJson(Map<String, dynamic> json) => _$MealPreferencesFromJson(json);
                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:43:57: Error: Method not found: '_$MacrosFromJson'.
  factory Macros.fromJson(Map<String, dynamic> json) => _$MacrosFromJson(json);
                                                        ^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:45:20: Error: The getter 'carbs' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'carbs'.
  int get total => carbs + protein + fat;
                   ^^^^^
lib/core/models/meal_models.dart:45:28: Error: The getter 'protein' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'protein'.
  int get total => carbs + protein + fat;
                           ^^^^^^^
lib/core/models/meal_models.dart:45:38: Error: The getter 'fat' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'fat'.
  int get total => carbs + protein + fat;
                                     ^^^
lib/core/models/meal_models.dart:60:65: Error: Method not found: '_$IdentifiedFoodFromJson'.
  factory IdentifiedFood.fromJson(Map<String, dynamic> json) => _$IdentifiedFoodFromJson(json);
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:78:63: Error: Method not found: '_$MealAnalysisFromJson'.
  factory MealAnalysis.fromJson(Map<String, dynamic> json) => _$MealAnalysisFromJson(json);
                                                              ^^^^^^^^^^^^^^^^^^^^^^
lib/core/models/meal_models.dart:90:62: Error: Method not found: '_$MealPayloadFromJson'.
  factory MealPayload.fromJson(Map<String, dynamic> json) => _$MealPayloadFromJson(json);
                                                             ^^^^^^^^^^^^^^^^^^^^^
lib/core/data/history_repository.dart:24:23: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
      _scans[analysis.id] = analysis;
                      ^^
lib/core/data/history_repository.dart:25:33: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
      _index.insert(0, analysis.id);
                                ^^
lib/core/data/history_repository.dart:35:21: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
    _scans[analysis.id] = analysis;
                    ^^
lib/core/data/history_repository.dart:36:28: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
    _index.remove(analysis.id);
                           ^^
lib/core/data/history_repository.dart:37:31: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
    _index.insert(0, analysis.id);
                              ^^
lib/core/data/history_repository.dart:57:44: Error: The method 'toJson' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing method, or defining a method named 'toJson'.
    return jsonEncode(payload.map((e) => e.toJson()).toList());
                                           ^^^^^^
lib/core/data/history_repository.dart:78:31: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
        .where((scan) => scan.timestamp.isBefore(threshold))
                              ^^^^^^^^^
lib/core/data/history_repository.dart:79:29: Error: The getter 'id' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'id'.
        .map((scan) => scan.id)
                            ^^
lib/core/data/history_repository.dart:111:17: Error: The getter 'mealTitle' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'mealTitle'.
          entry.mealTitle.toLowerCase().contains(query.toLowerCase());
                ^^^^^^^^^
lib/core/data/history_repository.dart:113:19: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
          (!entry.timestamp.isBefore(dateRange!.start) &&
                  ^^^^^^^^^
lib/core/data/history_repository.dart:114:22: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
              !entry.timestamp.isAfter(dateRange!.end));
                     ^^^^^^^^^
lib/core/data/history_repository.dart:136:46: Error: Too many positional arguments: 0 allowed, but 1 found.
Try removing the extra positional arguments.
  HistoryController(this._repository) : super(HistoryState.loading()) {
                                             ^
lib/core/data/history_repository.dart:144:13: Error: The getter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(isLoading: true);
            ^^^^^
lib/core/data/history_repository.dart:144:5: Error: The setter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(isLoading: true);
    ^^^^^
lib/core/data/history_repository.dart:153:13: Error: The getter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(entries: scans, isLoading: false);
            ^^^^^
lib/core/data/history_repository.dart:153:5: Error: The setter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(entries: scans, isLoading: false);
    ^^^^^
lib/core/data/history_repository.dart:159:15: Error: The getter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
      state = state.copyWith(query: query);
              ^^^^^
lib/core/data/history_repository.dart:159:7: Error: The setter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
      state = state.copyWith(query: query);
      ^^^^^
lib/core/data/history_repository.dart:164:13: Error: The getter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(dateRange: range, clearDateRange: range == null);
            ^^^^^
lib/core/data/history_repository.dart:164:5: Error: The setter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(dateRange: range, clearDateRange: range == null);
    ^^^^^
lib/core/data/history_repository.dart:169:13: Error: The getter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'state'.
    state = state.copyWith(entries: []);
            ^^^^^
lib/core/data/history_repository.dart:169:5: Error: The setter 'state' isn't defined for the class 'HistoryController'.
 - 'HistoryController' is from 'package:nutri_snap/core/data/history_repository.dart' ('lib/core/data/history_repository.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
    state = state.copyWith(entries: []);
    ^^^^^
lib/core/data/history_repository.dart:180:11: Error: Superclass has no method named 'dispose'.
    super.dispose();
          ^^^^^^^
lib/core/services/connectivity_service.dart:7:53: Error: Too many positional arguments: 0 allowed, but 1 found.
Try removing the extra positional arguments.
  ConnectivityController(this._connectivity) : super(false) {
                                                    ^
lib/core/services/connectivity_service.dart:17:7: Error: The setter 'state' isn't defined for the class 'ConnectivityController'.
 - 'ConnectivityController' is from 'package:nutri_snap/core/services/connectivity_service.dart' ('lib/core/services/connectivity_service.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
      state = result.every((entry) => entry == ConnectivityResult.none);
      ^^^^^
lib/core/services/connectivity_service.dart:19:7: Error: The setter 'state' isn't defined for the class 'ConnectivityController'.
 - 'ConnectivityController' is from 'package:nutri_snap/core/services/connectivity_service.dart' ('lib/core/services/connectivity_service.dart').
Try correcting the name to the name of an existing setter, or defining a setter or field named 'state'.
      state = result == ConnectivityResult.none;
      ^^^^^
lib/core/services/connectivity_service.dart:26:11: Error: Superclass has no method named 'dispose'.
    super.dispose();
          ^^^^^^^
lib/core/widgets/history_entry_card.dart:20:32: Error: The getter 'identifiedFoods' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'identifiedFoods'.
    final thumbnail = analysis.identifiedFoods.firstOrNull?.thumbnailUrl;
                               ^^^^^^^^^^^^^^^
lib/core/widgets/history_entry_card.dart:53:32: Error: The getter 'mealTitle' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'mealTitle'.
                      analysis.mealTitle,
                               ^^^^^^^^^
lib/core/widgets/history_entry_card.dart:58:60: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
                      '${NutriFormatters.shortDay(analysis.timestamp)} · ${NutriFormatters.time(analysis.timestamp)}',
                                                           ^^^^^^^^^
lib/core/widgets/history_entry_card.dart:58:106: Error: The getter 'timestamp' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'timestamp'.
                      '${NutriFormatters.shortDay(analysis.timestamp)} · ${NutriFormatters.time(analysis.timestamp)}',
                                                                                          ^^^^^^^^^
lib/core/widgets/history_entry_card.dart:69:55: Error: The getter 'totalCalories' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'totalCalories'.
                    NutriFormatters.calories(analysis.totalCalories),
                                                      ^^^^^^^^^^^^^
lib/core/widgets/history_entry_card.dart:81:34: Error: The getter 'confidence' isn't defined for the class 'MealAnalysis'.
 - 'MealAnalysis' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'confidence'.
                        analysis.confidence.name.toUpperCase(),
                                 ^^^^^^^^^^
lib/features/results/widgets/macro_donut_chart.dart:15:33: Error: The getter 'carbs' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'carbs'.
      _MacroSlice(value: macros.carbs.toDouble(), color: theme.colorScheme.primary, label: 'Carbs'),
                                ^^^^^
lib/features/results/widgets/macro_donut_chart.dart:16:33: Error: The getter 'protein' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'protein'.
      _MacroSlice(value: macros.protein.toDouble(), color: theme.colorScheme.secondary, label: 'Protein'),
                                ^^^^^^^
lib/features/results/widgets/macro_donut_chart.dart:18:23: Error: The getter 'fat' isn't defined for the class 'Macros'.
 - 'Macros' is from 'package:nutri_snap/core/models/meal_models.dart' ('lib/core/models/meal_models.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'fat'.
        value: macros.fat.toDouble(),
                      ^^^
../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/fl_chart-1.1.0/lib/src/chart/base/custom_interactive_viewer.dart:419:9: Error: The method 'translateByDouble' isn't defined for the class 'Matrix4'.
 - 'Matrix4' is from 'package:vector_math/vector_math_64.dart' ('../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/vector_math-2.1.4/lib/vector_math_64.dart').
Try correcting the name to the name of an existing method, or defining a method named 'translateByDouble'.
      ..translateByDouble(
        ^^^^^^^^^^^^^^^^^
../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/fl_chart-1.1.0/lib/src/chart/base/custom_interactive_viewer.dart:534:9: Error: The method 'scaleByDouble' isn't defined for the class 'Matrix4'.
 - 'Matrix4' is from 'package:vector_math/vector_math_64.dart' ('../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/vector_math-2.1.4/lib/vector_math_64.dart').
Try correcting the name to the name of an existing method, or defining a method named 'scaleByDouble'.
      ..scaleByDouble(clampedScale, clampedScale, clampedScale, 1);
        ^^^^^^^^^^^^^
../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/fl_chart-1.1.0/lib/src/chart/base/custom_interactive_viewer.dart:1114:7: Error: The method 'translateByDouble' isn't defined for the class 'Matrix4'.
 - 'Matrix4' is from 'package:vector_math/vector_math_64.dart' ('../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/vector_math-2.1.4/lib/vector_math_64.dart').
Try correcting the name to the name of an existing method, or defining a method named 'translateByDouble'.
    ..translateByDouble(rect.size.width / 2, rect.size.height / 2, 0, 1)
      ^^^^^^^^^^^^^^^^^
../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/fl_chart-1.1.0/lib/src/chart/base/custom_interactive_viewer.dart:1116:7: Error: The method 'translateByDouble' isn't defined for the class 'Matrix4'.
 - 'Matrix4' is from 'package:vector_math/vector_math_64.dart' ('../../../../../../../AppData/Local/Pub/Cache/hosted/pub.dev/vector_math-2.1.4/lib/vector_math_64.dart').
Try correcting the name to the name of an existing method, or defining a method named 'translateByDouble'.
    ..translateByDouble(-rect.size.width / 2, -rect.size.height / 2, 0, 1);
      ^^^^^^^^^^^^^^^^^
lib/core/data/preferences_repository.dart:65:30: Error: The type 'dynamic' is not exhaustively matched by the switch cases since it doesn't match 'Object()'.
Try adding a wildcard pattern or cases that match 'Object()'.
  return switch (preferences.theme) {
                             ^
Target kernel_snapshot_program failed: Exception


FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:compileFlutterBuildDebug'.
> Process 'command 'C:\Users\crims\Documents\0A08_Cache\8B02_Software\Flutter\flutter\bin\flutter.bat'' finished with non-zero exit value 1

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 33s
Running Gradle task 'assembleDebug'...                             33.8s
Error: Gradle task assembleDebug failed with exit code 1

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/nutri_snap
$