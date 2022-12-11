import 'package:get/get.dart';

class MainController extends GetxController {
  static const int _defaultTabIndex = 0;
  final RxInt _rxSelectedIndex = _defaultTabIndex.obs;

  int get selectedIndex => _rxSelectedIndex.value;

  set selectedIndex(int value) => _rxSelectedIndex.value = value;

  void reset() {
    _rxSelectedIndex.value = _defaultTabIndex;
  }

  static MainController? get instance {
    try {
      return Get.find<MainController>();
    } catch (_) {
      return null;
    }
  }
}
