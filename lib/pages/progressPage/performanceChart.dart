import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GameProgressChart extends StatelessWidget {
  final List<dynamic> progressData;

  GameProgressChart({required this.progressData});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: progressData
                .map((data) => FlSpot(
              DateTime.parse(data['timestamp']).millisecondsSinceEpoch.toDouble(),
              data['score'].toDouble(),
            ))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}
