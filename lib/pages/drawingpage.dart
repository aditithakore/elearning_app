import 'package:flutter/material.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final List<Path> _strokes = [];

  void _startStroke(double x, double y) {
    setState(() {
      _strokes.add(Path()..moveTo(x, y));
    });
  }

  void _moveStroke(double x, double y) {
    setState(() {
      _strokes.last.lineTo(x, y);
    });
  }

  void _clear() {
    setState(() {
      _strokes.clear(); // Clear all strokes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Page',style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Baloo 2',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete), // Clear icon
            onPressed: _clear, // Clear drawing when pressed
          ),
        ],
      ),
      body: GestureDetector(
        onPanDown: (details) => _startStroke(
          details.localPosition.dx,
          details.localPosition.dy,
        ),
        onPanUpdate: (details) => _moveStroke(
          details.localPosition.dx,
          details.localPosition.dy,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: DrawingPainter(_strokes),
          ),
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Path> strokes;

  DrawingPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      final paint = Paint()
        ..strokeWidth = 10
        ..color = Color(0xff000000)
        ..style = PaintingStyle.stroke;

      canvas.drawPath(stroke, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}