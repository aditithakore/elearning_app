import 'package:flutter/material.dart';

void main() {
  runApp(AnimalPuzzleGame());
}

class AnimalPuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PuzzleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<String> images = [
    'assets\images\animals\cat.png',
    'assets\images\animals\cat.png',
    'assets\images\animals\cat.png',
    'assets\images\animals\cat.png',
  ];

  List<String> shuffledImages = [];
  int emptyIndex = 3;

  @override
  void initState() {
    super.initState();
    shuffledImages = List.from(images)..shuffle();
    shuffledImages.add('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Puzzle'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: EdgeInsets.all(16.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTileTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: shuffledImages[index] != ''
                          ? DecorationImage(
                              image: AssetImage(shuffledImages[index]),
                              fit: BoxFit.cover,
                            )
                          : null,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: resetPuzzle,
            child: Text('Reset Puzzle'),
          ),
        ],
      ),
    );
  }

  void onTileTap(int index) {
    if (isAdjacent(index, emptyIndex)) {
      setState(() {
        String temp = shuffledImages[index];
        shuffledImages[index] = shuffledImages[emptyIndex];
        shuffledImages[emptyIndex] = temp;

        emptyIndex = index;
      });

      if (checkWin()) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You solved the puzzle!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetPuzzle();
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      }
    }
  }

  bool isAdjacent(int index1, int index2) {
    int row1 = index1 ~/ 2, col1 = index1 % 2;
    int row2 = index2 ~/ 2, col2 = index2 % 2;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  bool checkWin() {
    return List.generate(4, (index) => images[index]) ==
        shuffledImages.sublist(0, 4);
  }

  void resetPuzzle() {
    setState(() {
      shuffledImages = List.from(images)..shuffle();
      shuffledImages.add('');
      emptyIndex = 3;
    });
  }
}