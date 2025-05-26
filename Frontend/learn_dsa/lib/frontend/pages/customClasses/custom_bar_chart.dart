import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../backend/database/firestore_service.dart';

class TestResultsChart extends StatelessWidget {
  final List<double> results;

  const TestResultsChart({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    final chartWidth = MediaQuery.of(context).size.width - 70;
    final maximum = [for (int i = 1; i < results.length; i += 2) results[i]].reduce((a, b) => a > b ? a : b);


    return SizedBox(
      width: chartWidth,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maximum,
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
                      label = AppLocalizations.of(context)!.hash_table_chart_title;
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
          barGroups: List.generate(results.length ~/ 2, (index) {
            double answered = results[index * 2];
            double total = results[index * 2 + 1];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: maximum,
                  rodStackItems: [
                    BarChartRodStackItem(0, answered, Colors.lightGreen), // answered
                    BarChartRodStackItem(answered, total, Color(0xFF255f38)), // remaining
                    BarChartRodStackItem(total, maximum, Colors.grey.shade400), // missing part up to maximum
                  ],
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],

            );
          }),
        ),
      ),
    );
  }
}

// Helper class
class ChartWrapper extends StatelessWidget {
  const ChartWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<double>>(
      future: FirestoreService().fetchChartData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Hiba történt: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nincs adat a diagramhoz.'));
        }

        return TestResultsChart(results: snapshot.data!);
      },
    );
  }
}
