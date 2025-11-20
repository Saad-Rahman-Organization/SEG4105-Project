import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../models/meal_models.dart';
import '../utils/mock_data.dart';

abstract class HistoryRepository {
  Future<MealAnalysis?> getScan(String id);
  Future<List<String>> getScanIndex({required int limit, required int offset});
  Future<void> addScan(MealAnalysis analysis);
  Future<void> deleteScan(String id);
  Future<void> clearHistory();
  Future<void> pruneScans({required int olderThanDays});
  Future<String> exportHistory();
}

class InMemoryHistoryRepository implements HistoryRepository {
  InMemoryHistoryRepository() {
    final samples = MockData.sampleAnalyses;
    for (final analysis in samples) {
      _scans[analysis.id] = analysis;
      _index.insert(0, analysis.id);
    }
  }

  final Map<String, MealAnalysis> _scans = {};
  final List<String> _index = [];

  @override
  Future<void> addScan(MealAnalysis analysis) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _scans[analysis.id] = analysis;
    _index.remove(analysis.id);
    _index.insert(0, analysis.id);
  }

  @override
  Future<void> clearHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _scans.clear();
    _index.clear();
  }

  @override
  Future<void> deleteScan(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _scans.remove(id);
    _index.remove(id);
  }

  @override
  Future<String> exportHistory() async {
    final payload = _index.map((id) => _scans[id]!).toList();
    return jsonEncode(payload.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<String>> getScanIndex({required int limit, required int offset}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final end = (offset + limit).clamp(0, _index.length);
    if (offset >= end) return [];
    return _index.sublist(offset, end);
  }

  @override
  Future<MealAnalysis?> getScan(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return _scans[id];
  }

  @override
  Future<void> pruneScans({required int olderThanDays}) async {
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
      final matchesQuery = query.isEmpty ||
          entry.mealTitle.toLowerCase().contains(query.toLowerCase());
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

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => InMemoryHistoryRepository(),
);

final historyControllerProvider =
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final repository = ref.watch(historyRepositoryProvider);
  return HistoryController(repository);
});
