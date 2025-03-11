import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
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
                color: Colors.blue.shade900,
                radius: 40,
              ),
              PieChartSectionData(
                value: 22,
                title: 'List',
                color: Colors.blue.shade700,
                radius: 40,
              ),
              PieChartSectionData(
                value: 17,
                title: 'Queue',
                color: Colors.blue.shade500,
                radius: 40,
              ),
              PieChartSectionData(
                value: 14,
                title: 'Stack',
                color: Colors.blue.shade400,
                radius: 40,
              ),
              PieChartSectionData(
                value: 18,
                title: 'Hash Table',
                color: Colors.blue.shade300,
                radius: 40,
              ),
              PieChartSectionData(
                value: 10,
                title: 'BST',
                color: Colors.blue.shade200,
                radius: 40,
              ),
            ],
            sectionsSpace: 2,
            centerSpaceRadius: 50,
          ),
        ),
      ),
    );
  }
}
