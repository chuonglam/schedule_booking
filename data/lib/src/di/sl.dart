import 'package:data/src/network/client.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:data/src/di/sl.config.dart';

@InjectableInit(initializerName: r'$initDataGetIt')
Future<void> configureDataDependencies(
  final GetIt getIt,
) async {
  await DataClient.init();
  getIt.$initDataGetIt();
}
