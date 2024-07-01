import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:elearning_app/pages/colorShapes/colorShapesController.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ColorShapesUI extends StatelessWidget {
  final ColorShapeController colorController = Get.put(ColorShapeController());

  @override
  Widget build(BuildContext context) {
    colorController.reset();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Color Match Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              colorController.colorName.value,
              style: TextStyle(color: _getColor(colorController.colorName.value), fontSize: 24),
            )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // for (int index = 0; index < colorController.colorNames.length; index++)
                //   GestureDetector(
                //     onTap: () {
                //       colorController.checkColor(colorController.colorNames[index]);
                //     },
                //     child: Container(
                //       width: 80,
                //       height: 80,
                //       color: _getColor(colorController.colorNames[index]),
                //       child: Center(
                //         child: Text(
                //           colorController.colorNames[index],
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),


                GestureDetector(
                  onTap: (){
                    print("box1: ${colorController.box1.value}");
                    colorController.checkColor(colorController.box1.value);
                  },
                  child:
                  Obx(()=>
                      Container(
                        width: Get.width * 0.2,
                        height: Get.height * 0.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:
                            colorController.box1.value.toLowerCase() == 'red' ?
                            Colors.red:
                            colorController.box1.value.toLowerCase() == 'green'?
                            Colors.green:
                            colorController.box1.value.toLowerCase() == 'blue'?
                            Colors.blue:Colors.black,
                          shape: BoxShape.circle
                        ),

                        child: Text(colorController.box1.value),
                      ),
                  ),


                ),
                GestureDetector(
                  onTap: (){
                    print("box2: ${colorController.box2.value}");
                    colorController.checkColor(colorController.box2.value);
                  },
                  child:
                  Obx(()=>
                      Container(
                        width: Get.width * 0.2,
                        height: Get.height * 0.2,
                        color:
                        colorController.box2.value.toLowerCase() == 'red' ?
                        Colors.red:
                        colorController.box2.value.toLowerCase() == 'green'?
                        Colors.green:
                        colorController.box2.value.toLowerCase() == 'blue'?
                        Colors.blue:Colors.black,
                        child: Text(colorController.box2.value),
                      )
                  ),


                ),
                GestureDetector(
                  onTap: (){
                    print("box3: ${colorController.box3.value}");

                    colorController.checkColor(colorController.box3.value);
                  },
                  child:
                  Obx(() =>
                  Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.2,
                    color:
                    colorController.box3.value.toLowerCase() == 'red' ?
                    Colors.red:
                    colorController.box3.value.toLowerCase() == 'green'?
                    Colors.green:
                    colorController.box3.value.toLowerCase() == 'blue'?
                    Colors.blue:Colors.black,
                    child: Text(colorController.box3.value),
                  ),
                  )

                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(()=>
                    Text('Score: ${colorController.score.value}', style: TextStyle(fontSize: 24),)),

                SizedBox(height: 10),
                Obx(() =>
                colorController.isSuccess.value
                    ? Text(
                  'Success!',
                  style: TextStyle(color: Colors.green, fontSize: 24),
                )
                    : colorController.isFailed.value
                    ? Text(
                  'Failed!',
                  style: TextStyle(color: Colors.red, fontSize: 24),
                )
                    : Container()),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    colorController.reset();
                    colorController.colorNames.refresh(); // Refresh the observable list
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        );
  }

  Color _getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
