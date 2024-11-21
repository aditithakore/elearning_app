import 'package:elearning_app/pages/wordgame/wordGameController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WordGameController(),
      child: _WordGameView(),
    );
  }
}

class _WordGameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              _buildScoreBoard(),
              _buildImage(),
              _buildQuestion(),
              _buildSelectedLetters(),
              _buildKeyboard(),
              _buildReloadButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {},
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: controller.currentQuestionIndex > 0
                      ? () => controller.loadQuestion(controller.currentQuestionIndex - 1)
                      : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: controller.currentQuestionIndex < controller.questions.length - 1
                      ? () => controller.loadQuestion(controller.currentQuestionIndex + 1)
                      : null,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildScoreBoard() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                'Score: ${controller.score}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Container(
          height: 200,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(controller.currentImage, fit: BoxFit.contain),
        );
      },
    );
  }

  Widget _buildQuestion() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            controller.currentQuestion,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      },
    );
  }

  Widget _buildSelectedLetters() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            controller.currentAnswer.length,
                (index) => GestureDetector(
              onTap: () => controller.removeLetter(index),
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: controller.selectedLetters[index].isEmpty
                      ? Colors.white
                      : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    controller.selectedLetters[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: controller.selectedLetters[index].isEmpty
                          ? Colors.blue
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeyboard() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.availableLetters.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  int emptyIndex = controller.selectedLetters.indexOf('');
                  if (emptyIndex != -1) {
                    controller.selectLetter(
                      controller.availableLetters[index],
                      emptyIndex,
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      controller.availableLetters[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildReloadButton() {
    return Consumer<WordGameController>(
      builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: controller.resetGame,
                icon: Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  'Reset Game',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}