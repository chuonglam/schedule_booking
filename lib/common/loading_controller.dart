import 'package:get/get.dart';

mixin LoadingController on GetxController {
  final RxBool _loading = false.obs;
  final RxnString _error = RxnString();

  bool get isLoading => _loading.value;

  set isLoading(bool value) => _loading(value);

  String? get error => _error.value;

  set error(String? value) => _error(value);
}
