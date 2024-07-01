import 'package:get/get.dart';
import 'matchFruitsModel.dart';
class MatchFruitsLogic {
  List<ImageItem> items = [
    ImageItem('assets/images/apple.jpg', 'apple'),
    ImageItem('assets/images/banana.png', 'banana'),
    ImageItem('assets/images/cherry.png', 'cherry'),
    // Add more items as needed
  ].obs;
  dynamic shuffledItems = [].obs;

  MatchFruitsLogic() {
    shuffledItems = List.from(items)..shuffle();
  }
  bool checkMatch(ImageItem item1, ImageItem item2) {
    print("MatchSuccess");
    return item1.id == item2.id;
  }
}
