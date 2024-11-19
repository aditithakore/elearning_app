import 'dart:math';
import 'package:flutter/material.dart';

class ActivityWheel extends StatefulWidget {
  const ActivityWheel({super.key});

  @override
  _ActivityWheelState createState() => _ActivityWheelState();
}

class _ActivityWheelState extends State<ActivityWheel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0;
  int _selectedSegment = -1;
  bool _isSpinning = false;

  final List<Map<String, dynamic>> _segments = [
    {
      'activity': 'Compliment a \n stranger',
      'color': Colors.red,
      'points': 10
    },
    {
      'activity': 'Share a \n personal story',
      'color': Colors.blue,
      'points': 15
    },
    {
      'activity': 'Ask about \n someone\'s hobby',
      'color': Colors.green,
      'points': 20
    },
    {
      'activity': 'Give directions \n to someone',
      'color': Colors.yellow,
      'points': 12
    },
    {
      'activity': 'Start conversation \n with a new person',
      'color': Colors.purple,
      'points': 25
    },
    {
      'activity': 'Offer help \n to someone',
      'color': Colors.orange,
      'points': 18
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {
        _angle = _controller.value * 2 * pi;
      });
    })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _determineSelectedSegment();
        }
      });
  }

  void _determineSelectedSegment() {
    final segmentCount = _segments.length;
    final randomSpin = Random().nextDouble() * 2 * pi;

    setState(() {
      // Adjust angle to ensure random segment at top
      _angle = randomSpin - (2 * pi / segmentCount / 2);
      _selectedSegment = Random().nextInt(segmentCount);
      _isSpinning = false;
    });
  }

  void _spinWheel() {
    if (!_isSpinning) {
      setState(() {
        _isSpinning = true;
        _selectedSegment = -1;
      });

      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Skills Activity Wheel')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: WheelPainter(
                segments: _segments,
                angle: _angle,
                selectedSegment: _selectedSegment,
              ),
              child: Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedSegment != -1)
              Column(
                children: [
                  Text(
                    'Activity: ${_segments[_selectedSegment]['activity']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Points: ${_segments[_selectedSegment]['points']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: const Text('Spin Wheel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WheelPainter extends CustomPainter {
  final List<Map<String, dynamic>> segments;
  final double angle;
  final int selectedSegment;

  WheelPainter({
    required this.segments,
    required this.angle,
    required this.selectedSegment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw wheel background
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw segments
    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = 2 * pi / segments.length;
      final startAngle = i * sweepAngle + angle;

      final segmentPaint = Paint()
        ..color = segments[i]['color']
        ..style = PaintingStyle.fill;

      // Draw segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      // Draw activity text
      _drawSegmentText(canvas, center, radius, i, startAngle, sweepAngle);
    }

    // Draw wheel pointer
    final pointerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx - 10, center.dy - radius - 20)
      ..lineTo(center.dx + 10, center.dy - radius - 20)
      ..close();

    canvas.drawPath(path, pointerPaint);
  }

  void _drawSegmentText(Canvas canvas, Offset center, double radius,
      int segmentIndex, double startAngle, double sweepAngle) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: segments[segmentIndex]['activity'],
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '...',
    )..layout(maxWidth: radius);

    // Calculate text position in the middle of the segment
    final segmentCenterAngle = startAngle + sweepAngle / 2;
    final textRadius = radius * 0.6; // Positioned inside the wheel

    final textX = center.dx + textRadius * cos(segmentCenterAngle) - textPainter.width / 2;
    final textY = center.dy + textRadius * sin(segmentCenterAngle) - textPainter.height / 2;

    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}