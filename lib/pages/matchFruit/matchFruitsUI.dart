import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'matchFruitsController.dart';
import 'matchFruitsModel.dart';
class MatchFruitsUI extends StatelessWidget {
  final MatchFruitsController controller = Get.put(MatchFruitsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Game'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Match the Fruits!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: controller.gameLogic.items.length,
                    itemBuilder: (context, index) {
                      final item = controller.gameLogic.items[index];
                      return DragTarget<ImageItem>(
                        onAccept: (draggedItem) {
                          controller.matchItem(item, draggedItem);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Obx(() => Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: controller.matchedItems.contains(item.id)
                                  ? Colors.transparent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Center(
                              child: controller.matchedItems.contains(item.id)
                                  ? Container(child: Icon(Icons.check_circle)) // Show nothing if matched
                                  : Image.asset(item.imagePath),
                            ),
                          ));
                        },
                      );
                    },
                  )),
                ),
                Expanded(
                  child:
                  // Obx(() =>
                      GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                      itemCount: controller.gameLogic.shuffledItems.length,
                      itemBuilder: (context, index) {
                      final item = controller.gameLogic.shuffledItems[index];
                      return Draggable<ImageItem>(
                        data: item,
                        feedback: Image.asset(
                          item.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        childWhenDragging: Container(
                          color: Colors.grey,
                        ),
                        child: Obx(() => Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: controller.matchedItems.contains(item.id)
                              ? Container() // Show nothing if matched
                              : Image.asset(item.imagePath),
                        )),
                      );
                    },
                  ),
                  ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
