import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final Function(int) onAnswerSelected;

  const QuestionWidget(
      {Key? key, required this.question, required this.onAnswerSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        for (int i = 1; i <= 5; i++)
          ListTile(
            title: Text(answerText(i)), // Display answer choices
            leading: Radio<int>(
              value: i,
              groupValue: null,
              onChanged: (value) {
                if (value != null) {
                  onAnswerSelected(value);
                }
              },
            ),
          ),
        const Divider(), // Add dividers between questions
      ],
    );
  }

  String answerText(int value) {
    switch (value) {
      case 1:
        return 'Never';
      case 2:
        return 'Rarely';
      case 3:
        return 'Sometimes';
      case 4:
        return 'Often';
      case 5:
        return 'Always';
      default:
        return '';
    }
  }
}
