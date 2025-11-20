import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/models/meal_models.dart';
import '../../../core/utils/formatters.dart';

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
          height: 240,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 70,
              sections: sections
                  .map(
                    (slice) => PieChartSectionData(
                      value: slice.value,
                      color: slice.color,
                      radius: 72,
                      title: NutriFormatters.gramsShort(slice.value),
                      titleStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 8,
          children: sections
              .map(
                (slice) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
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
