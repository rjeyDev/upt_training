import 'package:get_it/get_it.dart';

import '../../../../presentation/navigation/navigation.dart';
import '../../remote/jwt.dart';

var sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<AppRouter>(AppRouter());
  sl.registerSingleton<JwtBox>(JwtBox());
  // sl.registerSingleton<Configuration>(Configuration());
  // sl.registerSingleton<Localization>(Localization());
}
