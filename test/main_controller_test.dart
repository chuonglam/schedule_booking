import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

void main() {
  late MainController mainController;

  setUp(() {
    mainController = MainController();
  });

  tearDown(() {
    mainController.dispose();
    Get.deleteAll();
  });

  test(
    'should update value of selectedIndex correctly',
    () {
      expect(mainController.selectedIndex, 0);
      Get.put(mainController);
      expect(mainController.selectedIndex, 0);
      mainController.selectedIndex = 1;
      expect(mainController.selectedIndex, 1);
    },
  );
}
