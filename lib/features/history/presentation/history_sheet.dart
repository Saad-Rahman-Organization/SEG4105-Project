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
    final controller = useMemoized(DraggableScrollableController.new);
    final searchController = useTextEditingController();
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

    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        controller: controller,
        initialChildSize: 0.18,
        minChildSize: 0.15,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.18, 0.5, 0.95],
        builder: (context, scrollController) {
          return DecoratedBox(
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
                          controller: searchController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search meals',
                          ),
                          onChanged: ref.read(historyControllerProvider.notifier).updateSearch,
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
                            children: [
                              const SizedBox(height: 40),
                              Icon(Icons.energy_savings_leaf, size: 48, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(height: 12),
                              Text(
                                'Your past scans will appear here.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 120),
                            ],
                          );
                        }
                        return ListView.builder(
                          controller: scrollController,
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
          );
        },
      ),
    );
  }
}
