import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/services/haptics_service.dart';
import '../../../core/widgets/history_entry_card.dart';

class HomeHistorySheet extends HookConsumerWidget {
  const HomeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const minSheetSize = 0.15;
    const initialSheetSize = 0.18;
    const midSheetSize = 0.5;
    const maxSheetSize = 0.95;

    final controller = useMemoized(DraggableScrollableController.new);
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final historyState = ref.watch(historyControllerProvider);

    useEffect(() {
      return controller.dispose;
    }, [controller]);

    useEffect(() {
      void listener() {
        const targets = [0.18, 0.5, 0.95];
        final size = controller.size;
        if (size <= 0) return;
        for (final target in targets) {
          if ((size - target).abs() < 0.015) {
            ref.read(hapticsServiceProvider).selection();
            break;
          }
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    void ensureExpanded() {
      if (controller.size < midSheetSize) {
        controller.animateTo(
          midSheetSize,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
        );
      }
    }

    void handleSearchChange(String value) {
      ref.read(historyControllerProvider.notifier).updateSearch(value);
      if (value.trim().isNotEmpty) {
        ensureExpanded();
      }
    }

    useEffect(() {
      void onFocus() {
        if (searchFocusNode.hasFocus) {
          ensureExpanded();
        }
      }

      searchFocusNode.addListener(onFocus);
      return () => searchFocusNode.removeListener(onFocus);
    }, []);

    Future<void> openDatePicker() async {
      final now = DateTime.now();
      final picked = await showDateRangePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: now.subtract(const Duration(days: 90)),
        lastDate: now,
      );
      if (picked != null) {
        ref.read(historyControllerProvider.notifier).setDateRange(picked);
      }
    }

    final filtersActive = (historyState.query.isNotEmpty || historyState.dateRange != null);

    final viewInsets = MediaQuery.viewInsetsOf(context);
    final listPadding = EdgeInsets.fromLTRB(16, 8, 16, viewInsets.bottom + 32);

    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        controller: controller,
        initialChildSize: initialSheetSize,
        minChildSize: minSheetSize,
        maxChildSize: maxSheetSize,
        snap: true,
        snapSizes: const [initialSheetSize, midSheetSize, maxSheetSize],
        builder: (context, scrollController) {
          return LayoutBuilder(
            builder: (context, constraints) {
              void handleDragUpdate(DragUpdateDetails details) {
                final delta = -details.primaryDelta! / constraints.maxHeight;
                final target = (controller.size + delta).clamp(minSheetSize, maxSheetSize);
                controller.jumpTo(target);
              }

              void handleDragEnd(DragEndDetails details) {
                final sizes = [initialSheetSize, midSheetSize, maxSheetSize];
                double closest = sizes.first;
                double minDiff = (controller.size - closest).abs();
                for (final s in sizes.skip(1)) {
                  final diff = (controller.size - s).abs();
                  if (diff < minDiff) {
                    minDiff = diff;
                    closest = s;
                  }
                }
                controller.animateTo(
                  closest,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                );
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: handleDragUpdate,
                onVerticalDragEnd: handleDragEnd,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withValues(alpha: 0.08),
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        height: 5,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                focusNode: searchFocusNode,
                                controller: searchController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search meals',
                                ),
                                onTap: ensureExpanded,
                                onChanged: handleSearchChange,
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              tooltip: 'Date range',
                              onPressed: openDatePicker,
                              icon: const Icon(Icons.filter_alt_outlined),
                            ),
                          ],
                        ),
                      ),
                      if (filtersActive)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                searchController.clear();
                                ref.read(historyControllerProvider.notifier)
                                  ..updateSearch('')
                                  ..setDateRange(null);
                              },
                              child: const Text('Clear filters'),
                            ),
                          ),
                        ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: ref.read(historyControllerProvider.notifier).refresh,
                          child: Builder(
                            builder: (context) {
                              final entries = historyState.filteredEntries;
                              if (historyState.isLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (entries.isEmpty) {
                                return ListView(
                                  controller: scrollController,
                                  padding: listPadding,
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  children: [
                                    const SizedBox(height: 48),
                                    Icon(Icons.inbox_outlined, size: 64, color: Theme.of(context).colorScheme.primary),
                                    const SizedBox(height: 16),
                                    Text(
                                      historyState.entries.isEmpty
                                          ? 'No meals saved yet'
                                          : 'No results match your search',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    if (historyState.entries.isEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Scan a meal to see it here and search later.',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                    const SizedBox(height: 120),
                                  ],
                                );
                              }
                              return ListView.builder(
                                controller: scrollController,
                                padding: listPadding,
                                physics: const AlwaysScrollableScrollPhysics(),
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                itemCount: entries.length,
                                itemBuilder: (context, index) {
                                  final item = entries[index];
                                  return HistoryEntryCard(
                                    analysis: item,
                                    onTap: () => context.pushNamed('results', pathParameters: {'id': item.id}),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
