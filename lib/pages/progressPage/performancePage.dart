import 'package:elearning_app/pages/progressPage/performanceChart.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class GameProgressPage extends StatelessWidget {
  final String userId;

  GameProgressPage(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Progress")),
      body: FutureBuilder(
        future: Utils().getGameProgress(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return GameProgressChart(progressData: snapshot.data!);
          }
          return Center(child: Text("No progress data available"));
        },
      ),
    );
  }
}
