import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'sl.config.dart';

final GetIt sl = GetIt.instance;
@InjectableInit(initializerName: r'$initGetIt')
void configureDependencies() {
  configureDataDependencies(sl);
  $initGetIt(sl);
}
