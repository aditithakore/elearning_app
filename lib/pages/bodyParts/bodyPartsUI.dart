import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bodyPartController.dart';

class BodyPartsUI extends StatelessWidget {
  final BodyPartController controller = Get.put(BodyPartController());
  // final TTSController ttsController = Get.put(TTSController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Body Parts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Eye',
              style: TextStyle(
                fontSize: 48,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ttsController.speak('Eye');
              },
              child: Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }
}
