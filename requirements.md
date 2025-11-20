# NutriSnap UI Requirements (Flutter)

## 1. Vision & Core Principles

- **Goal:** Deliver a polished, intuitive, Android-first experience that helps users photograph meals and receive AI-style nutrition estimates (all mocked).
- **Target User:** Health-conscious beginners (25-45) who want fast, visual feedback more than perfect precision.
- **Aesthetic:** Light, warm, modern. Soft natural greens, vibrant yellow-greens, and clean off-whites to signal health and positivity.
- **Scope:** Front-end only. Capture inputs, show progress, and render mock results. All backend/AI responses are simulated locally.

## 2. Target Platforms & Tooling

- **Framework:** Flutter, Dart 3+, no Android Studio required.
- **Navigation:** `go_router` with nested shell routes for main tabs and grouped feature stacks.
- **Camera & Media:** `camera` for capture preview, `image_picker` for gallery, `image` for resize/compress/base64, `permission_handler` for runtime prompts.
- **State Management:** `riverpod` + `hooks_riverpod` for reactive UI/state; `freezed` + `json_serializable` for immutable models and mock API shapes.
- **Storage:** `hive` (encrypted box for profile/preferences/history) and `shared_preferences` for lightweight flags (e.g., onboarding shown).
- **Theming & UI:** Material 3 with custom `ColorScheme`; `flutter_svg` for icons/illustrations; `google_fonts` for Inter; `responsive_framework` for layout breakpoints.
- **Animation:** Implicit animations first; `flutter_animate` for page/section reveals; `rive` optional for loading hero if time permits.
- **Charts & Lists:** `fl_chart` for donut/macros; `sliver_tools` and `pull_to_refresh` (or `refresh_indicator`) for performant history lists.
- **Lint/Format:** `flutter_lints` plus pedantic rules; `dart format` enforced. CI should run `flutter analyze` and `flutter test`.
- **Build Target:** Android API 26+ (minSdk 26), targetSdk latest stable. iOS support optional but keep platform checks clean.

## 3. Project Structure & Architecture

Feature-first layout inside `lib/` to keep UI, state, and data localized.

```
lib/
├── app/
│   ├── app.dart                # MaterialApp + router + providers
│   ├── bootstrap.dart          # runApp, provider observers, error handling
│   └── theme.dart              # ColorScheme, text styles, spacing, shadows
├── core/
│   ├── services/               # haptics, connectivity, permissions
│   ├── data/                   # hive boxes, adapters, repositories
│   ├── widgets/                # common buttons, inputs, cards, sheets
│   ├── utils/                  # formatters, validators, converters
│   └── models/                 # shared DTOs/entities (freezed)
├── features/
│   ├── onboarding/
│   ├── home/
│   ├── camera/
│   ├── processing/
│   ├── results/
│   ├── history/
│   └── settings/
├── routing/                    # go_router config and route names
└── main.dart                   # entry point
assets/
├── fonts/                      # Inter files
├── icons/                      # SVG line icons
└── illustrations/              # onboarding/empty states
```

## 4. Data Models & Contracts (Dart)

Use `freezed` + `json_serializable` for immutability, equals/hash, and mock JSON support.

### `UserProfile` (Hive box: `profileBox`)

```dart
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id, // local UUID
    String? name,
    required double heightValue,
    required HeightUnit heightUnit, // cm | in
    required double weightValue,
    required WeightUnit weightUnit, // kg | lb
    required ActivityLevel activityLevel,
    int? dailyCalorieGoal,
    required bool onboardingCompleted,
  }) = _UserProfile;
}
```

### `AppPreferences` (Hive box: `preferencesBox`)

```dart
@freezed
class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    required AppTheme theme, // light | dark | system
    required UnitsPreference units, // metric | imperial
  }) = _AppPreferences;
}
```

### `MealPayload` (sent to mock analyzer)

```dart
@freezed
class MealPayload with _$MealPayload {
  const factory MealPayload({
    required String localId, // UUID per capture
    required UserProfile user,
    required CaptureInfo capture,
    required MealPreferences preferences,
  }) = _MealPayload;
}
```

### `MealAnalysis` (dummy response)

```dart
@freezed
class MealAnalysis with _$MealAnalysis {
  const factory MealAnalysis({
    required String id,
    required String localId,
    required String mealTitle,
    required int totalCalories,
    required Confidence confidence, // high | medium | low
    required DateTime timestamp,
    required List<IdentifiedFood> identifiedFoods,
    required Macros macros,
    required String qualitativeFeedback,
    required List<String> warnings,
  }) = _MealAnalysis;
}
```

## 5. Theming & Visual Language

- **ColorScheme (light):**
  - `primary` #5FB662; `secondary` #D4F06A; `surface` #FFFFFF; `background` #F8F6F1; `onPrimary` #0F1A0F; `error` #D9534F; `outline` #EAE8E1.
- **ColorScheme (dark):**
  - `primary` #6BCB70; `secondary` #C9E85A; `surface` #1E1E1E; `background` #121212; `onPrimary` #F5FFF5; `error` #E57373; `outline` #3A3A3A.
- **Typography:** Inter via `google_fonts`; `displayLarge` 32/Bold, `headlineMedium` 24/SemiBold, `bodyLarge` 16/Regular, `labelMedium` 14/Medium, `bodySmall` 12/Regular.
- **Spacing:** Base 8dp grid.
- **Shape:** 16dp radius for cards/buttons, 8dp for chips/inputs.
- **Motion:** Default 300ms easeOut cubic. Use `AnimatedSwitcher`/`AnimatedOpacity` for micro-transitions; `flutter_animate` for staged entrance on lists/sections.
- **Charts:** `fl_chart` donut with animated sweep. Use SVG line icons at 24dp, 1.5px stroke.

## 6. Screen Specifications (Flutter)

### 0. Onboarding (`features/onboarding`)
- **Trigger:** Shown when `onboardingCompleted` is false.
- **Flow:** `PageView` with 3 pages + `SmoothPageIndicator`.
  1) Welcome: logo, title "Welcome to NutriSnap", intro text, primary CTA.
  2) Permissions: explain camera need; "Grant Access" triggers `permission_handler`. If permanently denied, CTA becomes "Open Settings" via `openAppSettings`; small "Skip for now".
  3) Profile Setup: form fields for name/height/weight/activity with validation overlays; inline errors beneath inputs.
- **Completion:** Persist profile, set flag, navigate via `go_router.replaceNamed('home')`.

### 1. Home (`features/home`)
- **Layout:** `CustomScrollView` with gradient background (background to lighter primary).
- **Header:** Logo + settings icon. Offline pill (secondary color) fades in when connectivity service reports loss.
- **Hero:** Greeting text using name if present.
- **Primary CTA:** Gradient button "Scan a Meal" with haptic light impact and scale to 0.95 on press (using `TweenAnimationBuilder`).
- **History Preview:** Anchored card with latest scan; tapping or dragging reveals History sheet. Animate slide-up/fade-in on first load.

### 2. History Bottom Sheet (`features/history`)
- **Interaction:** `DraggableScrollableSheet` with snap sizes ~0.15, 0.5, 0.95. Provide light haptic when a snap target is hit.
- **Data:** Backed by `HistoryRepository` (Hive). Supports pull-to-refresh and pagination via `ListView.custom`/`SliverChildBuilderDelegate`.
- **UI:** Card rows with thumbnail, title, timestamp, calories. Tap opens Results for that entry.
- **Empty State:** Illustration + text "Your past scans will appear here."
- **Filtering:** Sticky header with search (300ms debounce), date range modal, and "Clear Filters" button that appears when active.

### 3. Settings (`features/settings`)
- **Layout:** Sectioned form using `ListView` + `SectionHeader`.
- **Profile:** Inputs for Name, Height, Weight, Activity Level, Daily Calorie Goal. Unit toggles convert values immediately and persist.
- **BMI:** Read-only field computed as `weight(kg) / (height(m))^2`.
- **Appearance:** Segmented control for theme (light/dark/system).
- **Data Management:** Buttons "Export History" and "Clear All Data" (confirm dialog: "Are you sure? This will permanently delete all your data, including your scan history.").
- **About:** App version and dummy links to Privacy/Terms.

### 4. Camera (`features/camera`)
- **Permissions:** Hook/service checks `Permission.camera`. If denied, show empty state with "Open Settings".
- **UI:** Full-screen `CameraPreview` with instruction "Center your meal".
- **Controls:** Shutter (haptic), flash toggle, gallery import (image_picker).
- **Processing:** Resize to max 1920px, 80% JPEG quality, base64 encode before creating `MealPayload`.
- **Post-Capture:** Bottom sheet preview with "Retake" and "Use Photo". Shared element transition to Processing when accepted.

### 5. Processing (`features/processing`)
- **UI:** Blocking screen (no back). Circular progress animation; text "Analyzing your meal..." with rotating subtext messages ("Detecting ingredients...", etc.) fading every 2s.
- **Logic:** Calls mock `analyzeMeal` with 15s timeout. On failure, toast "Analysis Failed. Please try again." and show "Try Again" CTA.

### 6. Results (`features/results`)
- **Layout:** Scrollable sections that fade/slide in sequentially.
- **Hero Card:** Meal title, calories, confidence chip.
- **Macros Card:** Animated donut chart with legend.
- **Identified Foods:** List of foods; tapping opens modal detail (bigger image, macro breakdown).
- **Feedback Card:** Qualitative feedback + warnings list.
- **Actions:** "Scan New Meal" (primary) and "Save to History" (secondary). Not auto-saved; when saved, button becomes "Saved!" and disables. Header includes Share icon.

## 7. Local Data & Performance

- **Storage:** Hive boxes for profile, preferences, and history; encrypt boxes with a generated key stored in `secure_storage`.
- **HistoryRepository contract:**

```dart
abstract class HistoryRepository {
  Future<MealAnalysis?> getScan(String id);
  Future<List<String>> getScanIndex({required int limit, required int offset});
  Future<void> addScan(MealAnalysis analysis);
  Future<void> deleteScan(String id);
  Future<void> clearHistory();
  Future<void> pruneScans({required int olderThanDays});
  Future<String> exportHistory(); // JSON string
}
```

- **Indexing:** Maintain `scan_id_index` list and individual `scan_{id}` entries. Background job (on cold start if >24h) prunes scans older than 90 days.
- **Image Cache:** Use `cached_network_image` for remote thumbnails; prefer memory/disk caching defaults.
- **Performance:** Avoid rebuilding camera preview; keep controllers in providers. Use slivers and `AutomaticKeepAliveClientMixin` for tabs.

## 8. Error & Offline Handling

- **Permissions:** Clear empty states + link to app settings when denied.
- **Processing Errors:** Toast + retry CTA on analyzer failures or timeouts.
- **Offline Mode:** Connectivity service toggles offline pill. When offline, analyzer returns cached dummy response so flow stays usable.
- **Storage Errors:** On Hive write failures, show toast "Failed to save data. Please check storage." with retry.
- **Data Validation:** Validate mock responses against `MealAnalysis` schema; show "Could not parse analysis" if invalid.

## 9. Accessibility (A11y)

- **Semantics:** All controls get `Semantics` labels/hints/roles; ensure `excludeSemantics` where combining text + icons.
- **Focus:** Trap focus inside `ModalBottomSheet` via `FocusScope`; logical order through `FocusTraversalGroup`.
- **Announcements:** Use `SemanticsService.announce` for dynamic updates ("Analysis complete", "History updated").
- **Contrast & Size:** Meet WCAG AA for light/dark; respect system text scale with responsive layouts.
- **Touch Targets:** Minimum 48x48dp.