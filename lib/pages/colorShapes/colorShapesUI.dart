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
            Obx(() =>
            colorController.score.value == 10 ?
                Text(
                  'Congratulations',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ):
                Text(
              colorController.colorName.value,
              style: TextStyle(color: _getColor(colorController.colorName.value), fontSize: 24),
            )),
            SizedBox(height: 5),
            Obx(()=>
            !colorController.isGameOver.value?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                GestureDetector(
                  onTap: (){
                    print("box1: ${colorController.box1.value}");
                    colorController.checkColor(colorController.box1.value);
                  },
                  child:
                  Obx(()=>
                      Container(
                        width: Get.width * 0.1,
                        height: Get.height * 0.18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color:Colors.black12
                          ),
                            borderRadius: BorderRadius.circular(5),
                          color: colorController.box1.value.toLowerCase() == 'red' ?
                          Colors.red:
                          colorController.box1.value.toLowerCase() == 'green'?
                          Colors.green:
                          colorController.box1.value.toLowerCase() == 'blue'?
                          Colors.blue:
                          colorController.box1.value.toLowerCase() == 'orange'?
                          Colors.orange:
                          colorController.box1.value.toLowerCase() == 'yellow'?
                          Colors.yellow:
                          Colors.black,
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
                        alignment: Alignment.center,
                        width: Get.width * 0.1,
                        height: Get.height * 0.18,
                        color:
                        colorController.box2.value.toLowerCase() == 'red' ?
                        Colors.red:
                        colorController.box2.value.toLowerCase() == 'green'?
                        Colors.green:
                        colorController.box2.value.toLowerCase() == 'blue'?
                        Colors.blue:
                        colorController.box2.value.toLowerCase() == 'orange'?
                        Colors.orange:
                        colorController.box2.value.toLowerCase() == 'yellow'?
                        Colors.yellow:
                        Colors.black,
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
                          width: Get.width * 0.1,
                          height: Get.height * 0.18,
                          alignment: Alignment.center,
                          color:
                          colorController.box3.value.toLowerCase() == 'red' ?
                          Colors.red:
                          colorController.box3.value.toLowerCase() == 'green'?
                          Colors.green:
                          colorController.box3.value.toLowerCase() == 'orange'?
                          Colors.orange:
                          colorController.box3.value.toLowerCase() == 'yellow'?
                          Colors.yellow:
                          colorController.box3.value.toLowerCase() == 'blue'?
                          Colors.blue:Colors.black,
                          child: Text(colorController.box3.value),
                        ),
                    )

                ),
              ],
            ):
            ElevatedButton(
              onPressed: () {
                colorController.replay();
                // Get.to(ColorShapesUI());  // Reset the game
              },
              child: Text('Replay'),
            ),
            ),

                SizedBox(height: 5),
                Obx(()=>
                    Text('Score: ${colorController.score.value}', style: TextStyle(fontSize: 20),)),

                SizedBox(height: 5),
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
                  Obx(()=>!colorController.isGameOver.value?
                  ElevatedButton(
                    onPressed: () {
                      colorController.reset();
                      colorController.colorNames.refresh(); // Refresh the observable list
                    },
                  child: Text('Next'),
                ):Container()),
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
        case "yellow":
        return Colors.yellow;
        case "orange":
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
