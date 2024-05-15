import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/bottom_navigator/bottom_navbar_widget.dart';
import '../navigation.dart';

@RoutePage(name: 'BottomNavigatorRoute')
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigatorState();
}

late TabsRouter tabsRouter;

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const HomeRoute(),
        const AddContentRoute(),
        ProfileRoute(isMyProfile: true),
      ],
      bottomNavigationBuilder: (context, router) {
        tabsRouter = router;
        return BottomNavbarWidget(router: router);
      },
    );
  }
}
