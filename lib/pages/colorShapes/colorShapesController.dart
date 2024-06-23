import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colorsShapesModel.dart';

class ColorShapeController extends GetxController{
  final List<ColorsShapesModel> _shapes=[
    ColorsShapesModel(shape: 'Circle', color:Colors.blue),
    ColorsShapesModel(shape: 'Square', color:Colors.green),
    ColorsShapesModel(shape: 'Triangle', color:Colors.amber),
    ColorsShapesModel(shape: 'Rectangle', color:Colors.pink),
  ];
  final _currentIndex=0.obs;
  final _score=0.obs;
  List<ColorsShapesModel> get shapes=>_shapes;

  int get currentIndex=>_currentIndex.value;
  int get score=>_score.value;

  void nextShape(){
    _currentIndex.value=(_currentIndex.value+1)%_shapes.length;
  }
  void handleTap(int index){
    if(index == _currentIndex){
      nextShape();
    }
    else{
      print("Try Again");
    }
  }
}