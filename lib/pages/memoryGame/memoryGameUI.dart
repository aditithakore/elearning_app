// ignore_for_file: prefer_const_constructors

import 'package:elearning_app/pages/memoryGame/gameManager.dart';
import 'package:elearning_app/pages/memoryGame/wordTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MemoryGameUI extends StatefulWidget {
  const MemoryGameUI({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGameUI> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.10;
    return ChangeNotifierProvider(
      create: (context) => GameManager(),
      child: Scaffold(
        body: Center(
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: widthPadding, right: widthPadding),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: size.height * 0.38),
            itemBuilder: (BuildContext context, int index) =>
                WordTile(index: index),
          ),
        ),
      ),
    );
  }
}


