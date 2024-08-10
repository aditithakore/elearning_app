import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SensoryBinPage extends StatefulWidget {
  @override
  _SensoryBinPageState createState() => _SensoryBinPageState();
}

class _SensoryBinPageState extends State<SensoryBinPage> {
  Offset _ballPosition = Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Virtual Sensory Bin'),
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.brown[300],
              child: Center(
                child: Text('Dig into the virtual sand!', style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),),
              ),
            ),
          ),
          Positioned(
            left: _ballPosition.dx - 25, // Adjust for ball size
            top: _ballPosition.dy - 25,  // Adjust for ball size
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _ballPosition += details.delta;
                  HapticFeedback.lightImpact(); // Haptic feedback
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}