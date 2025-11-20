import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/models/meal_models.dart';

class MacroDonutChart extends StatelessWidget {
  const MacroDonutChart({super.key, required this.macros});

  final Macros macros;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = [
      _MacroSlice(value: macros.carbs.toDouble(), color: theme.colorScheme.primary, label: 'Carbs'),
      _MacroSlice(value: macros.protein.toDouble(), color: theme.colorScheme.secondary, label: 'Protein'),
      _MacroSlice(
        value: macros.fat.toDouble(),
        color: theme.colorScheme.primary.withValues(alpha: 0.5),
        label: 'Fat',
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 70,
              sections: sections
                  .map(
                    (slice) => PieChartSectionData(
                      value: slice.value,
                      color: slice.color,
                      radius: 70,
                      title: '${slice.value.toInt()}g',
                      titleStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          children: sections
              .map(
                (slice) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: slice.color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(slice.label, style: theme.textTheme.bodyMedium),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _MacroSlice {
  const _MacroSlice({required this.value, required this.color, required this.label});

  final double value;
  final Color color;
  final String label;
}
