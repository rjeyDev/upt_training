import 'package:auto_route/auto_route.dart';

import '../../../data/datasource/local/service_locator/service_locator.dart';
import '../../../data/datasource/remote/jwt.dart';
import '../navigation.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (sl.get<JwtBox>().authenticated) {
      resolver.next();
    } else {
      resolver.redirect(LoginRoute(onResult: (result) {
        resolver.next(result);
      }));
    }
  }
}
