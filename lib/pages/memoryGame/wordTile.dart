import 'package:elearning_app/pages/memoryGame/gameManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flip_animation.dart';

class WordTile extends StatelessWidget {
  const WordTile({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(
      builder: (_, notifier, __) => GestureDetector(
        onTap: () {
          notifier.tileTapped(index);
        },
        child: FlipAnimation(
          reverse: false,
          animationCompleted: (completed) {
            print('call back $completed');
          },
          animate: notifier.flippedCards[index] || notifier.matchedPairs.contains(index),
          word: Container(
            color: Colors.deepPurple,
            child: Center(
              child: _getShapeWidget(notifier.gameShapes[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getShapeWidget(String shape) {
    switch (shape) {
      case 'circle':
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        );
      case 'square':
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
          ),
        );
      case 'triangle':
        return CustomPaint(
          size: Size(50, 50),
          painter: TrianglePainter(),
        );
      default:
        return Icon(Icons.error, size: 50, color: Colors.white);
    }
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}