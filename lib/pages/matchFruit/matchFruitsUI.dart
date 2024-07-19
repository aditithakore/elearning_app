import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'matchFruitsController.dart';
import 'matchFruitsModel.dart';

class MatchFruitsUI extends StatelessWidget {
  final MatchFruitsController controller = Get.put(MatchFruitsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Game'),
        actions: [
          ElevatedButton(
            onPressed: () {
              controller.reset();
            },
            child: Text('Replay'),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Obx(() => Center(
            child: Text(
              controller.isSuccess.value ? 'Congratulations' : 'Match the Fruits!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          SizedBox(height: 20),
          Obx(
                () => !controller.isSuccess.value
                ? Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: controller.items.map((item) {
                        return DragTarget<ImageItem>(
                          onAccept: (draggedItem) {
                            controller.matchItem(item, draggedItem);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Obx(
                                  () => Card(
                                elevation: 4,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: controller.matchedItems.contains(item.id)
                                        ? Colors.transparent
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: Center(
                                    child: controller.matchedItems.contains(item.id)
                                        ? Container(child: Icon(Icons.check_circle))
                                        : Image.asset(item.imagePath, height: 50, width: 50),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(), // Show exactly 3 items in the upper row
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: controller.shuffledItems.map((item) {
                        return Draggable<ImageItem>(
                          data: item,
                          feedback: Image.asset(
                            item.imagePath,
                            width: 50,
                            height: 50,
                          ),
                          childWhenDragging: Container(
                            color: Colors.yellowAccent,
                          ),
                          child: Obx(
                                () => Card(
                              elevation: 4,
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade500),
                                ),
                                child: controller.matchedItems.contains(item.id)
                                    ? Container(child: Obx(() => Text(controller.matchedMessage.value)))
                                    : Image.asset(item.imagePath, height: 50, width: 50),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
                : ElevatedButton(
              onPressed: () {
                controller.reset();
              },
              child: Text('Replay'),
            ),
          ),
        ],
      ),
    );
  }
}
