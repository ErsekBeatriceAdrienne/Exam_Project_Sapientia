import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestResultsChart extends StatelessWidget {
  final List<double> results;

  const TestResultsChart({super.key, required this.results});

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
                      label = AppLocalizations.of(context)!.array_page_title;
                      break;
                    case 1:
                      label = AppLocalizations.of(context)!.stack_page_title;
                      break;
                    case 2:
                      label = AppLocalizations.of(context)!.queue_page_title;
                      break;
                    case 3:
                      label = AppLocalizations.of(context)!.list_page_title;
                      break;
                    case 4:
                      label = AppLocalizations.of(context)!.bt_page_title;
                      break;
                    case 5:
                      label = AppLocalizations.of(context)!.hash_page_title;
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
            //final baseColor = Colors.primaries[index % Colors.primaries.length];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: 30,
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      value,
                      Colors.lightGreen, //baseColor,
                    ),
                    BarChartRodStackItem(
                      value,
                      30,
                      Colors.lightGreen.shade800,//baseColor.shade200,
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
