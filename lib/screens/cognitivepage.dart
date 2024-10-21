import 'package:elearning_app/pages/rotatesplash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elearning_app/pages/dashboard.dart';
import 'package:elearning_app/screens/dashboard_screen.dart';


class CognitivePage extends StatelessWidget {
  const CognitivePage({super.key});

  Future<void> _showThankYouDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: Text('Thank you for your response!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateWithSplash(Widget destination) async {
    await _showThankYouDialog(Get.context!);
    Get.to(() => const Rotatesplash());
    
    await Future.delayed(const Duration(seconds: 3));
    
    Get.off(() => destination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Text(
                'COGNITIVE',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Icon(Icons.people, size: 100, color: Colors.green),
              SizedBox(height: 40),
              Text(
                'Can your child play with toys with buttons and moving parts?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Yes'),
                onPressed: () => _navigateWithSplash(Dashboard()),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('No'),
                onPressed: () => _navigateWithSplash(Dashboard()),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}