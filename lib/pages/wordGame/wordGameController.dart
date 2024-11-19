import 'package:flutter/cupertino.dart';

class WordGameController extends ChangeNotifier{
  String currentAnswer=' ';
  String currentImage=' ';
  String currentQuestion=' ';
  int currentQuestionIndex=0;
  int score=0;
  List<String> selectedLetters=[];
  List<String> availableLetters=[];
  bool isCorrect=false;
  List<Map<String,String>> questions=[
    {
      'image': 'assets/images/fruits/apple.png',
      'answer': 'APPLE',
      'question': 'Which fruit is red and keeps the doctor away?'
    },
    {
      'image': 'assets/images/words/earth.png',
      'answer': 'EARTH',
      'question': 'Our planet name is?'
    },
    {
      'image': 'assets/images/words/car.png',
      'answer': 'CAR',
      'question': 'Which vehicle has four wheels and moves on roads?'
    },
    {
      'image': 'assets/images/animals/dog.png',
      'answer': 'DOG',
      'question': 'Which animal says \'woof woof\'?'
    },
    {
      'image': 'assets/images/words/ball.png',
      'answer': 'BALL',
      'question': 'What is round and used to play games?'
    },
    {
      'image': 'assets/images/words/cow.png',
      'answer': 'COW',
      'question': 'Which animal gives us milk?'
    },
    {
      'image': 'assets/images/words/three.png',
      'answer': 'THREE',
      'question': 'What number comes after two?'
    },
    {
      'image': 'assets/images/fruits/banana.png',
      'answer': 'BANANA',
      'question': 'Which fruit is yellow and monkeys love to eat?'
    },
    {
      'image': 'assets/images/words/circle.png',
      'answer': 'CIRCLE',
      'question': 'Identify the shape?'
    },
    {
      'image': 'assets/images/words/sun.png',
      'answer': 'SUN',
      'question': 'What shines brightly in the sky during the day?'
    },
    {
      'image': 'assets/images/words/moon.png',
      'answer': 'MOON',
      'question': 'What can you see in the sky at night?'
    },
    {
      'image': 'assets/images/words/clock.png',
      'answer': 'CLOCK',
      'question': 'What tells us the time?'
    },
    {
      'image': 'assets/images/animals/cat.png',
      'answer': 'CAT',
      'question': 'Which animal says \'meow\'?'
    },
    {
      'image': 'assets/images/words/sunflower.png',
      'answer': 'SUNFLOWER',
      'question': 'Which flower is yellow and faces the sun?'
    },
    {
      'image': 'assets/images/words/orange.png',
      'answer': 'ORANGE',
      'question': 'Which fruit is the same color as its name?'
    },

    //more
  ];
  WordGameController(){
    loadQuestion(0);
  }

  void loadQuestion(int index) {
    if(index<questions.length){
      currentQuestionIndex=index;
      currentAnswer=questions[index]['answer']??'';
      currentImage=questions[index]['image']??'';
      currentQuestion=questions[index]['question']??'';
      initializeGame();
    }
  }
  void initializeGame() {
    selectedLetters=List.filled(currentAnswer.length,'');
    Set<String>letters=currentAnswer.split('').toSet();
    String alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    while(letters.length<16){
      letters.add(alphabet[DateTime.now().millisecondsSinceEpoch % 26]); // it gives randomno. everytime btwn 0-25 to beaded in options
    }
    availableLetters=letters.toList()..shuffle();
    isCorrect = false;
    notifyListeners();
  }
  void selectLetter(String letter, int index){
    if (index >= 0 && index < selectedLetters.length) {
    selectedLetters[index]=letter;
    checkAnswer();
    notifyListeners();
    }
  }
  void removeLetter(int index){
    if (index >= 0 && index < selectedLetters.length) {
      selectedLetters[index] = '';
      isCorrect = false;
      notifyListeners();
    }
  }

  void checkAnswer() {
    String currentWord = selectedLetters.join();

    // Check if all letters are filled
    if (currentWord.length == currentAnswer.length) {
      if (currentWord == currentAnswer && !isCorrect) {
        // Correct answer
        isCorrect = true;
        updateScore();
        Future.delayed(Duration(seconds: 1), () {
          nextQuestion();
        });
      } else if (!isCorrect) {
        // Incorrect answer only if all slots are filled
        reduceScore();
      }
    }
    notifyListeners();
  }

  void reduceScore() {
    int basePoints = 5; // Reduce points cautiously
    if (score > 0) {
      score -= basePoints;
    }
    notifyListeners();
  }


  void updateScore() {
    int basePoints = 10;
    score += basePoints;
    notifyListeners();
  }
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      loadQuestion(currentQuestionIndex + 1);
    }
  }
  void resetGame() {
    score = 0;
    loadQuestion(0);
  }

}
