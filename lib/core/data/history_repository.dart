import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_models.dart';

abstract class HistoryRepository {
  Future<MealAnalysis?> getScan(String id);
  Future<List<String>> getScanIndex({required int limit, required int offset});
  Future<void> addScan(MealAnalysis analysis);
  Future<void> updateScan(MealAnalysis analysis);
  Future<void> deleteScan(String id);
  Future<void> clearHistory();
  Future<void> pruneScans({required int olderThanDays});
  Future<String> exportHistory();
}

class LocalHistoryRepository implements HistoryRepository {
  LocalHistoryRepository._(this._prefs);

  factory LocalHistoryRepository(SharedPreferences prefs) {
    final repo = LocalHistoryRepository._(prefs);
    repo._hydrated = repo._hydrate();
    return repo;
  }

  static const _scansKey = 'history_scans_v1';
  final SharedPreferences _prefs;
  late final Future<void> _hydrated;

  final Map<String, MealAnalysis> _scans = {};
  final List<String> _index = [];

  Future<void> _ensureReady() => _hydrated;

  Future<void> _hydrate() async {
    final stored = _prefs.getString(_scansKey);
    if (stored == null) return;
    try {
      final decoded = jsonDecode(stored) as List<dynamic>;
      final entries = decoded.cast<Map<String, dynamic>>().map(MealAnalysis.fromJson).toList();
      _scans.clear();
      _index.clear();
      for (final entry in entries) {
        _scans[entry.id] = entry;
        _index.add(entry.id);
      }
    } catch (_) {
      await _prefs.remove(_scansKey);
      _scans.clear();
      _index.clear();
    }
  }

  Future<void> _persist() async {
    final payload = _index.map((id) => _scans[id]!).map((e) => e.toJson()).toList();
    await _prefs.setString(_scansKey, jsonEncode(payload));
  }

  @override
  Future<void> addScan(MealAnalysis analysis) async {
    await _ensureReady();
    _scans[analysis.id] = analysis;
    _index.remove(analysis.id);
    _index.insert(0, analysis.id);
    await _persist();
  }

  @override
  Future<void> clearHistory() async {
    await _ensureReady();
    _scans.clear();
    _index.clear();
    await _prefs.remove(_scansKey);
  }

  @override
  Future<void> updateScan(MealAnalysis analysis) async {
    await _ensureReady();
    _scans[analysis.id] = analysis;
    _index.remove(analysis.id);
    _index.insert(0, analysis.id);
    await _persist();
  }

  @override
  Future<void> deleteScan(String id) async {
    await _ensureReady();
    _scans.remove(id);
    _index.remove(id);
    await _persist();
  }

  @override
  Future<String> exportHistory() async {
    await _ensureReady();
    final payload = _index.map((id) => _scans[id]!).toList();
    return jsonEncode(payload.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<String>> getScanIndex({required int limit, required int offset}) async {
    await _ensureReady();
    final end = (offset + limit).clamp(0, _index.length);
    if (offset >= end) return [];
    return _index.sublist(offset, end);
  }

  @override
  Future<MealAnalysis?> getScan(String id) async {
    await _ensureReady();
    return _scans[id];
  }

  @override
  Future<void> pruneScans({required int olderThanDays}) async {
    await _ensureReady();
    final threshold = DateTime.now().subtract(Duration(days: olderThanDays));
    final idsToRemove = _scans.values
        .where((scan) => scan.timestamp.isBefore(threshold))
        .map((scan) => scan.id)
        .toList();
    for (final id in idsToRemove) {
      _scans.remove(id);
      _index.remove(id);
    }
  }
}

class HistoryState {
  const HistoryState({
    required this.entries,
    required this.isLoading,
    required this.query,
    required this.dateRange,
  });

  factory HistoryState.loading() => HistoryState(
        entries: const [],
        isLoading: true,
        query: '',
        dateRange: null,
      );

  final List<MealAnalysis> entries;
  final bool isLoading;
  final String query;
  final DateTimeRange? dateRange;

  List<MealAnalysis> get filteredEntries {
    return entries.where((entry) {
      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          entry.mealTitle.toLowerCase().contains(q) ||
          (entry.mealTag?.toLowerCase().contains(q) ?? false) ||
          entry.identifiedFoods.any((food) => food.name.toLowerCase().contains(q)) ||
          entry.ingredients.any((ing) => ing.name.toLowerCase().contains(q));
      final withinRange = dateRange == null ||
          (!entry.timestamp.isBefore(dateRange!.start) &&
              !entry.timestamp.isAfter(dateRange!.end));
      return matchesQuery && withinRange;
    }).toList();
  }

  HistoryState copyWith({
    List<MealAnalysis>? entries,
    bool? isLoading,
    String? query,
    DateTimeRange? dateRange,
    bool clearDateRange = false,
  }) {
    return HistoryState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      query: query ?? this.query,
      dateRange: clearDateRange ? null : (dateRange ?? this.dateRange),
    );
  }
}

class HistoryController extends StateNotifier<HistoryState> {
  HistoryController(this._repository) : super(HistoryState.loading()) {
    refresh();
  }

  final HistoryRepository _repository;
  Timer? _debounce;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    final ids = await _repository.getScanIndex(limit: 20, offset: 0);
    final scans = <MealAnalysis>[];
    for (final id in ids) {
      final scan = await _repository.getScan(id);
      if (scan != null) {
        scans.add(scan);
      }
    }
    state = state.copyWith(entries: scans, isLoading: false);
  }

  void updateSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      state = state.copyWith(query: query);
    });
  }

  void setDateRange(DateTimeRange? range) {
    state = state.copyWith(dateRange: range, clearDateRange: range == null);
  }

  Future<void> clearHistory() async {
    await _repository.clearHistory();
    state = state.copyWith(entries: []);
  }

  Future<void> addAnalysis(MealAnalysis analysis) async {
    await _repository.addScan(analysis);
    await refresh();
  }

  Future<void> updateAnalysis(MealAnalysis analysis) async {
    await _repository.updateScan(analysis);
    await refresh();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => throw UnimplementedError('HistoryRepository provider not initialized'),
);

final historyControllerProvider =
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final repository = ref.watch(historyRepositoryProvider);
  return HistoryController(repository);
});
