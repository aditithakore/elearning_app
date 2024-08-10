import 'package:get/get.dart';

class SocialSkillsGameController extends GetxController{
  final scenario=[
    {
      'image': ['assets/images/social/s2c1.png', 'assets/images/social/s2c2.png'],
      'question': 'John went to buy a watermelon that costs Rs 100.\n He has Rs 200 with him. What should he do?',
      'options': ['Ask the shopkeeper if he can buy one watermelon \n and then request Rs 100 back as change', 'Shy away and return back home'],
      'correctAnswer': 'Say sorry and explain',
    },
    {
      'image': ['assets/images/social/s1c1.png', 'assets/images/social/s1c2.png'],
      'question':'How do you greet someone you just met?',
      'options':['Ignore them','Say hello and introduce yourself'],
      'correctAnswer': 'Say hello and introduce yourself'
    },
    {
      'image': ['assets/images/social/s1c1.png', 'assets/images/social/s3c2.png'],
      'question': 'The teacher asks you a question, and you know the answer. What should you do?',
      'options': [
        'Raise your hand and wait to be called on',
        'Keep Quiet'
      ],
      'correctAnswer': 'Raise your hand and wait to be called on',
    },
    {
      'image': ['assets/images/social/s3c1.png', 'assets/images/social/parent.jpg'],
      'question': 'How should you apologize if you make a mistake?',
      'options': ['Ignore it', 'Say sorry and explain'],
      'correctAnswer': 'Say sorry and explain',
    },
    {
      'image': ['assets/images/social/s3c1.png', 'assets/images/social/parent.jpg'],
      'question': 'You want to go to a friend’s house. What should you do?',
      'options': [
        'Ask your parents for permission',
        'Go without telling them'
      ],
      'correctAnswer': 'Ask your parents for permission',
    },
  ];
  var scenarioIndex=0.obs;
  var selected=''.obs;
  var score=0.obs;
  var selectedOption = ''.obs;
  var isCorrect = false.obs;

  @override
  void onInit(){
    super.onInit();
  }
  void loadScenario() {
    selected.value = '';
    isCorrect.value = false;
    selectedOption.value = '';
  }
  //to check if selected option is correct
  void check(String option) {
    selectedOption.value = option;
    if (option == scenario[scenarioIndex.value]['correctAnswer']) {
      score++;
      isCorrect.value = true;
    } else {
      isCorrect.value = false;
    }

    // Delay the next scenario to show the border color
    Future.delayed(Duration(seconds: 1), () {
      scenarioIndex.value = (scenarioIndex.value + 1) % scenario.length;
      if (scenarioIndex.value == 0) {
        showCongratulations();
      } else {
        loadScenario();
      }
    });
  }

  void showCongratulations() {
    Get.defaultDialog(
      title: 'Congratulations!',
      middleText: 'You have completed the game.\nYour score is: ${score.value}',
      onConfirm: () {
        score.value = 0;
        scenarioIndex.value = 0;
        Get.back();
      },
    );
  }
}