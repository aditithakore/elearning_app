import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: AdditionGame(),
    );
  }
}

class AdditionGame extends StatefulWidget {
  @override
  _AdditionGameState createState() => _AdditionGameState();
}

class _AdditionGameState extends State<AdditionGame> {
  int score = 0;
  int num1 = 0;
  int num2 = 0;
  List<int> options = [];
  String message = ""; 

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final random = Random();
    num1 = random.nextInt(5) + 1;
    num2 = random.nextInt(5) + 1;
    int correctAnswer = num1 + num2;

    options = [
      correctAnswer,
      correctAnswer + random.nextInt(3) + 1,
      correctAnswer - random.nextInt(3) - 1
    ];
    options.shuffle();

    setState(() {
      message = ""; 
    });
  }

  void checkAnswer(int answer) {
    if (answer == num1 + num2) {
      setState(() {
        score++;
        message = "Right!"; 
        generateQuestion();
      });
    }
  }

  Widget buildEmojiRow(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          count, (index) => Icon(Icons.square, color: Colors.purple))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addition Game :"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score: $score", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            if (message.isNotEmpty) 
              Text(message,
                  style: TextStyle(fontSize: 24, color: Colors.green)),
            SizedBox(height: 20),
            buildEmojiRow(num1),
            Text("+", style: TextStyle(fontSize: 30)),
            buildEmojiRow(num2),
            Text("= ?", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map((option) {
                return GestureDetector(
                  onTap: () => checkAnswer(option),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildEmojiRow(option),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}