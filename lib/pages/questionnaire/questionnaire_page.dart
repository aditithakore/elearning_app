import 'package:elearning_app/pages/questionnaire/question_widget.dart';
import 'package:elearning_app/pages/questionnaire/questionnaire_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionnaireScreen extends StatelessWidget {
  final QuestionnaireController controller = Get.put(QuestionnaireController());

  QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              'Section ${controller.currentSectionIndex.value + 1}/${controller.csvFileNames.length}',
            )),
      ),
      body: PageView.builder(
        controller: controller.pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Disable manual swiping between sections
        itemCount: controller.csvFileNames.length,
        itemBuilder: (context, index) {
          return Obx(() => SingleChildScrollView(
                // Wrap with SingleChildScrollView
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0;
                          i < controller.currentSectionQuestions.length;
                          i++)
                        QuestionWidget(
                          question: controller.currentSectionQuestions[i],
                          onAnswerSelected: (answer) =>
                              controller.saveAnswer(answer),
                        ),
                      const SizedBox(height: 20),
                      if (controller.isLastSection())
                        ElevatedButton(
                          onPressed: controller.submitQuestionnaire,
                          child: const Text('Submit'),
                        )
                      else
                        ElevatedButton(
                          onPressed: controller
                              .nextSection, // Call nextSection to load next CSV
                          child: const Text('Next'),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
