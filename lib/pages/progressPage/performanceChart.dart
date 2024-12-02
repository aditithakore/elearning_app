import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

//SOMEWHAT WORKING
// class GameProgressChart extends StatelessWidget {
//   final List<Map<String, dynamic>> progressData;

//   GameProgressChart({required this.progressData});

//   @override
//   Widget build(BuildContext context) {
//     final groupedByGame = groupByGame(progressData);

//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(show: true),
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final index = value.toInt();
//                 if (index >= progressData.length) return Container();
//                 final timestamp = DateTime.parse(progressData[index]['timestamp']);
//                 return Text(DateFormat('HH:mm').format(timestamp));
//               },
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: true),
//           ),
//         ),
//         borderData: FlBorderData(show: true),
//         lineBarsData: groupedByGame.entries.map((entry) {
//           final gameName = entry.key;
//           final gameData = entry.value;

//           return LineChartBarData(
//             spots: gameData.asMap().entries.map((e) {
//               return FlSpot(e.key.toDouble(), e.value['score'].toDouble());
//             }).toList(),
//             isCurved: true,
//             color: _getColorForGame(gameName),
//             barWidth: 2,
//             belowBarData: BarAreaData(
//               show: true,
//               color: _getColorForGame(gameName).withOpacity(0.3),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Map<String, List<Map<String, dynamic>>> groupByGame(List<Map<String, dynamic>> data) {
//     final grouped = <String, List<Map<String, dynamic>>>{};
//     for (final entry in data) {
//       grouped.putIfAbsent(entry['gameName'], () => []).add(entry);
//     }
//     return grouped;
//   }

//   Color _getColorForGame(String gameName) {
//     switch (gameName) {
//       case "English":
//         return Colors.blue;
//       case "Match":
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }

//Import for mapIndexed

class GameProgressChart extends StatefulWidget {
  final List<Map<String, dynamic>> progressData;

  const GameProgressChart({super.key, required this.progressData});

  @override
  State<GameProgressChart> createState() => _GameProgressChartState();
}

class _GameProgressChartState extends State<GameProgressChart> {
  String? selectedGame;
  final List<String> gameNames = [];

  @override
  void initState() {
    super.initState();
    final uniqueGames = widget.progressData
        .map((e) => e['gameName'])
        .whereType<String>()
        .toSet();
    gameNames.addAll(uniqueGames);
    if (gameNames.isNotEmpty) {
      selectedGame = gameNames.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gameNames.isEmpty) {
      return const Center(child: Text('No game progress data available.'));
    }
    var filteredData = widget.progressData
        .where((e) => e['gameName'] == selectedGame)
        .toList();
    filteredData = [
      for (var i = 0;
          i < (filteredData.length > 7 ? 7 : filteredData.length);
          i++)
        filteredData[i]
    ].toList();
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedGame,
          items: gameNames.map((gameName) {
            return DropdownMenuItem<String>(
              value: gameName,
              child: Text(gameName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGame = value;
            });
          },
          decoration: const InputDecoration(labelText: 'Select Game'),
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= filteredData.length) {
                        return const Text('');
                      }
                      try {
                        final timestamp =
                            DateTime.parse(filteredData[index]['timestamp']!);
                        return Text(DateFormat('HH:mm').format(timestamp));
                      } catch (e) {
                        return const Text(
                            ''); //Handle parsing errors gracefully
                      }
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
              barGroups: _buildBarGroups(filteredData),
              borderData: FlBorderData(show: true),
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxY(filteredData), //Set maxY for consistent scaling
            ),
          ),
        ),
      ],
    );
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    return data.map((e) => double.parse(e['score'].toString())).reduce(max);
  }

  List<BarChartGroupData> _buildBarGroups(List<Map<String, dynamic>> data) {
    return data.mapIndexed((index, entry) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry['score'].toDouble(),
            color: _getColorForGame(entry['gameName']!),
            width: 15,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _getColorForGame(String gameName) {
    switch (gameName) {
      case "English":
        return Colors.blue;
      case "Match":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}















//EXTRA TRYING CODE
// class GameProgressChart extends StatefulWidget {
//   final List<Map<String, dynamic>> progressData;

//   GameProgressChart({required this.progressData});


  
//   @override
//   State<StatefulWidget> createState() => _BarChartSample7State();
// }
// class _BarChartSample7State extends State<GameProgressChart> {
//   BarChartGroupData generateBarGroup(
//     int x,
//     Color color,
//     double value,
//     double shadowValue,
//   ) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: value,
//           color: color,
//           width: 6,
//         ),
//       ],
//       showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
//     );
//   }

//   int touchedGroupIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: AspectRatio(
//         aspectRatio: 1.4,
//         child: BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceBetween,
//             borderData: FlBorderData(
//               show: true,
//               border: Border.symmetric(
//                 horizontal: BorderSide(
//                   color: Colors.black.withOpacity(0.2),
//                 ),
//               ),
//             ),
//             titlesData: FlTitlesData(
//               show: true,
//               leftTitles: AxisTitles(
//                 drawBelowEverything: true,
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 30,
//                   getTitlesWidget: (value, meta) {
//                     return Text(
//                       value.toInt().toString(),
//                       textAlign: TextAlign.left,
//                     );
//                   },
//                 ),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 36,
//                   getTitlesWidget: (value, meta) {
//                     final index = value.toInt();
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: _IconWidget(
//                         color: widget.dataList[index].color,
//                         isSelected: touchedGroupIndex == index,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               rightTitles: const AxisTitles(),
//               topTitles: const AxisTitles(),
//             ),
//             gridData: FlGridData(
//               show: true,
//               drawVerticalLine: false,
//               getDrawingHorizontalLine: (value) => FlLine(
//                 color: AppColors.borderColor.withOpacity(0.2),
//                 strokeWidth: 1,
//               ),
//             ),
//             barGroups: widget.dataList.asMap().entries.map((e) {
//               final index = e.key;
//               final data = e.value;
//               return generateBarGroup(
//                 index,
//                 data.color,
//                 data.value,
//                 data.shadowValue,
//               );
//             }).toList(),
//             maxY: 20,
//             barTouchData: BarTouchData(
//               enabled: true,
//               handleBuiltInTouches: false,
//               touchTooltipData: BarTouchTooltipData(
//                 getTooltipColor: (group) => Colors.transparent,
//                 tooltipMargin: 0,
//                 getTooltipItem: (
//                   BarChartGroupData group,
//                   int groupIndex,
//                   BarChartRodData rod,
//                   int rodIndex,
//                 ) {
//                   return BarTooltipItem(
//                     rod.toY.toString(),
//                     TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: rod.color,
//                       fontSize: 18,
//                       shadows: const [
//                         Shadow(
//                           color: Colors.black26,
//                           blurRadius: 12,
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               touchCallback: (event, response) {
//                 if (event.isInterestedForInteractions &&
//                     response != null &&
//                     response.spot != null) {
//                   setState(() {
//                     touchedGroupIndex = response.spot!.touchedBarGroupIndex;
//                   });
//                 } else {
//                   setState(() {
//                     touchedGroupIndex = -1;
//                   });
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BarData {
//   const _BarData(this.color, this.value, this.shadowValue);
//   final Color color;
//   final double value;
//   final double shadowValue;
// }

// class _IconWidget extends ImplicitlyAnimatedWidget {
//   const _IconWidget({
//     required this.color,
//     required this.isSelected,
//   }) : super(duration: const Duration(milliseconds: 300));
//   final Color color;
//   final bool isSelected;

//   @override
//   ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
//       _IconWidgetState();
// }

// class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
//   Tween<double>? _rotationTween;

//   @override
//   Widget build(BuildContext context) {
//     final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
//     final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
//     return Transform(
//       transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
//       origin: const Offset(14, 14),
//       child: Icon(
//         widget.isSelected ? Icons.face_retouching_natural : Icons.face,
//         color: widget.color,
//         size: 28,
//       ),
//     );
//   }

//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _rotationTween = visitor(
//       _rotationTween,
//       widget.isSelected ? 1.0 : 0.0,
//       (dynamic value) => Tween<double>(
//         begin: value as double,
//         end: widget.isSelected ? 1.0 : 0.0,
//       ),
//     ) as Tween<double>?;
//   }
// }
