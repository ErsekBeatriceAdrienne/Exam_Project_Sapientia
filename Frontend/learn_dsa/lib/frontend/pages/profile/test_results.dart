import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 10,
                title: 'Array',
                color: Colors.purple.shade900,
                radius: 40,
              ),
              PieChartSectionData(
                value: 22,
                title: 'List',
                color: Colors.purple.shade700,
                radius: 40,
              ),
              PieChartSectionData(
                value: 17,
                title: 'Queue',
                color: Colors.purple.shade500,
                radius: 40,
              ),
              PieChartSectionData(
                value: 14,
                title: 'Stack',
                color: Colors.purple.shade400,
                radius: 40,
              ),
              PieChartSectionData(
                value: 18,
                title: 'Hash Table',
                color: Colors.purple.shade300,
                radius: 40,
              ),
              PieChartSectionData(
                value: 10,
                title: 'BST',
                color: Colors.purple.shade200,
                radius: 40,
              ),
            ],
            sectionsSpace: 2,
            centerSpaceRadius: 60,
          ),
        ),
      ),
    );
  }
}
