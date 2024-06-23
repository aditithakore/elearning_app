import 'package:elearning_app/pages/colorShapes/colorShapesController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ColorShapesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorShapeController>(
      init: ColorShapeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Learn Shapes and Colors'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                      () => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: controller.shapes[controller.currentIndex].color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        controller.shapes[controller.currentIndex].shape,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Obx(
                      () => GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: controller.shapes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.handleTap(index),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            color: controller.shapes[index].color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              controller.shapes[index].shape,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32),
                Obx(
                      () => Text(
                    'Score: ${ controller.score }',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
