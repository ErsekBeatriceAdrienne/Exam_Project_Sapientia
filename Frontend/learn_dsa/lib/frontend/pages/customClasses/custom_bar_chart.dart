import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TestResultsChart extends StatelessWidget {
  final List<double> results;

  TestResultsChart({required this.results});

  @override
  Widget build(BuildContext context) {
    final chartWidth = MediaQuery.of(context).size.width - 70;

    return SizedBox(
      width: chartWidth,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 30,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(fontSize: 12);
                  String label;
                  switch (value.toInt()) {
                    case 0:
                      label = 'Array';
                      break;
                    case 1:
                      label = 'Stack';
                      break;
                    case 2:
                      label = 'Queue';
                      break;
                    case 3:
                      label = 'List';
                      break;
                    case 4:
                      label = 'Tree';
                      break;
                    case 5:
                      label = 'Hash';
                      break;
                    default:
                      label = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(label, style: style),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: results.asMap().entries.map((entry) {
            int index = entry.key;
            double value = entry.value;
            final baseColor = Colors.primaries[index % Colors.primaries.length];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: 30,
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      value,
                      baseColor,
                    ),
                    BarChartRodStackItem(
                      value,
                      30,
                      baseColor.shade200,
                    ),
                  ],
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],

            );
          }).toList(),
        ),
      ),
    );
  }
}
