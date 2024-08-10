import 'package:get/get.dart';

class SocialSkillsGameController extends GetxController{
  final scenario=[
    {
      'image': 'assets/images/social/s1c1.jpg',
      'question': 'John went to buy a watermelon that costs Rs 100. He has Rs 200 with him. What should he do?',
      'options': ['Ask the shopkeeper if he can buy one watermelon  and then request Rs 100 back as change', 'Shy away and return back home'],
      'correctAnswer': 'Say sorry and explain',
    },
    {
      'image':'assets/images/social/s1c2.jpg',
      'question':'How do you greet someone you just met?',
      'options':['Ignore them','Say hello and introduce yourself'],
      'correctAnswer': 'Say hello and introduce yourself'
    },
    {
      'image':'image1',
      'question':'How do you greet someone you just met?',
      'options':['Ignore them','Say hello and introduce yourself'],
      'correctAnswer': 'Say hello and introduce yourself'
    },
    {
      'image': 'assets/images/scenarios/scenario4.png',
      'question': 'How should you apologize if you make a mistake?',
      'options': ['Ignore it', 'Say sorry and explain'],
      'correctAnswer': 'Say sorry and explain',
    },
    {
      'image':'image1',
      'question':'How do you greet someone you just met?',
      'options':['Ignore them','Say hello and introduce yourself'],
      'correctAnswer': 'Say hello and introduce yourself'
    },
    {
      'image':'image1',
      'question':'How do you greet someone you just met?',
      'options':['Ignore them','Say hello and introduce yourself'],
      'correctAnswer': 'Say hello and introduce yourself'
    },
  ];
  var scenarioIndex=0.obs;
  var selected=''.obs;
  var score=0.obs;

  @override
  void onInit(){
    super.onInit();
  }
  void loadScenario() {
    selected.value = '';
  }
  //to check if selected option is correct
void check(String option){
    if(option==scenario[scenarioIndex.value]['correctAnswer']){
      score++;
      //variable bool true
    }
    scenarioIndex.value=(scenarioIndex.value+1)% scenario.length;
    if (scenarioIndex.value == 0) {
      showCongratulations();
    } else {
      loadScenario();
    }
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