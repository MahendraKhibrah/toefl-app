import 'package:flutter/material.dart';
import 'package:toefl/utils/list_ext.dart';

import 'all_route.dart';

class NavigatorHistory extends NavigatorObserver {
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (route?.settings.name == null) {
      return;
    }
    AllRoutes.routeStacks.add(route);
    _printRouteStack();
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    AllRoutes.routeStacks.removeLastWhere(
      (element) => element?.settings.name == route?.settings.name,
    );
    _printRouteStack();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    AllRoutes.routeStacks.removeLastWhere(
      (element) => element?.settings.name == oldRoute?.settings.name,
    );
    AllRoutes.routeStacks.add(newRoute);
    _printRouteStack();
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    AllRoutes.routeStacks.removeLastWhere(
      (element) => element?.settings.name == route?.settings.name,
    );
    _printRouteStack();
  }

  void _printRouteStack() {
    final routeNames = AllRoutes.routeStacks
        .map(
          (e) => '\'${e?.settings.name}\'',
        )
        .join(', ');

    debugPrint('route stack: [$routeNames]');
  }
}
