import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'sl.config.dart';

@InjectableInit(initializerName: r'$initGetIt')
void configureDataDependencies(final GetIt getIt) {
  $initGetIt(getIt);
}
