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
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surfaceContainerHighest;
    final rawSlices = [
      _MacroSlice(value: macros.carbs.toDouble(), color: theme.colorScheme.primary, label: 'Carbs'),
      _MacroSlice(value: macros.protein.toDouble(), color: theme.colorScheme.secondary, label: 'Protein'),
      _MacroSlice(
        value: macros.fat.toDouble(),
        color: theme.colorScheme.primary.withValues(alpha: 0.55),
        label: 'Fat',
      ),
    ];

    const baseShareFraction = 0.05; // keeps very small slices visible while preserving ordering
    final total = rawSlices.fold<double>(0, (sum, s) => sum + s.value);
    final baseBoost = total * baseShareFraction;

    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PieChart(
            PieChartData(
              startDegreeOffset: -90,
              sectionsSpace: 10,
              centerSpaceRadius: 54,
              sections: rawSlices
                  .map((slice) => PieChartSectionData(
                        value: slice.value + baseBoost,
                        color: slice.color,
                        radius: 96,
                        borderSide: BorderSide(color: cardColor, width: 6),
                        title: NutriFormatters.gramsShort(slice.value),
                        titlePositionPercentageOffset: 0.55,
                        titleStyle: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 8,
          children: rawSlices
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
