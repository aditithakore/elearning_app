import 'package:flutter/material.dart';

import '../../utils/utils.dart';

import 'performanceChart.dart';

class GameProgressPage extends StatelessWidget {
  final String userId;

  GameProgressPage(this.userId);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Progress")),
      body: FutureBuilder<List<dynamic>>( // Specify the type for better type safety
        future: Utils().getGameProgress(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = Utils().getLastThreeAttempts(snapshot.data!); // Call it correctly
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GameProgressChart(progressData: data),
            );
          }
          return const Center(child: Text("No progress data available")); //Use const for better performance
        },
      ),
    );
  }
}
