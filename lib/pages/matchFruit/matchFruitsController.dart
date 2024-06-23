import 'package:get/get.dart';
import 'matchFruitsModel.dart';
import 'matchFruitsLogic.dart';


class MatchFruitsController extends GetxController {
  var gameLogic = MatchFruitsLogic();
  var matchedItems = <String>[].obs;

  void matchItem(ImageItem target, ImageItem dragged) {
    if (gameLogic.checkMatch(target, dragged)) {
      matchedItems.add(target.id);
    }
  }
  String? getMatchedImage(String id) {
    return gameLogic.items.firstWhereOrNull((item) => item.id == id)?.imagePath;
  }
}
