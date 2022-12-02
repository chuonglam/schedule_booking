import 'package:data/data.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Rxn<User> _currentUser = Rxn();
  final RxInt _currentPage = RxInt(0);

  int get currentPage => _currentPage.value;

  User? get currentUser => _currentUser.value;

  bool get isLoggedIn => currentUser != null;

  void changePage(int idx) => _currentPage(idx);

  void login() {
    _currentUser.value = User(id: 'id', username: 'username');
  }

  void logout() {
    _currentUser.value = null;
  }
}
