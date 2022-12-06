import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt _rxSelectedIndex = 0.obs;

  int get selectedIndex => _rxSelectedIndex.value;

  set selectedIndex(int value) => _rxSelectedIndex.value = value;
}
