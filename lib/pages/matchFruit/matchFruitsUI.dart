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

    return Stack(
      children:[Container(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // title: Text('Drag and Drop Game'),
          backgroundColor: Colors.transparent,
          actions: [
            // ElevatedButton(
            //   onPressed: () {
            //     controller.reset();
            //   },
            //   child: Text('Replay'),
            // ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'), // Replace with your background image path
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
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
                                        () => SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Card(
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
                                                ? Container(child: Icon(Icons.check_circle,size:50,color: Colors.green,))
                                                : Image.asset(item.imagePath, height: 125, width: 125),
                                          ),
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
                                  width: 120,
                                  height: 120,
                                ),
                                childWhenDragging: Container(
                                  color: Colors.yellowAccent,
                                ),
                                child: Obx(
                                      () => SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Card(
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
            )
          ],
        ),
      ),
    )]);
  }
}
