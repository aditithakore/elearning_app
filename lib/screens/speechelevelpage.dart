import 'package:elearning_app/screens/socialpage.dart';
import 'package:flutter/material.dart';

class SpeechLevelPage extends StatefulWidget {
  const SpeechLevelPage({super.key});
  @override
  _SpeechLevelPageState createState() => _SpeechLevelPageState();
}

class _SpeechLevelPageState extends State<SpeechLevelPage> {
  String selectedLevel = 'Nonverbal';

  final List<String> levels = [
    'Nonverbal',
    'Nonverbal but can tell yes / no',
    'Cannot speak but knows words',
    'Does speak but not everyone understands',
    'Verbal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRELIMINARY', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.child_care,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              'Speech Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please select your child\'s speech level.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ...levels
                .map((level) => RadioListTile(
                      title: Text(level),
                      value: level,
                      groupValue: selectedLevel,
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value.toString();
                        });
                      },
                    ))
                .toList(),
            Spacer(),
            ElevatedButton(
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SocialPage()),
                        );
              },
            ),
          ],
        ),
      ),
    );
  }
}
