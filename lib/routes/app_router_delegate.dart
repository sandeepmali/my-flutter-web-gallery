import 'package:flutter/material.dart';
import 'package:web_gallery/pages/contact.dart';
import 'package:web_gallery/pages/home.dart';
import 'package:web_gallery/pages/notification.dart';
import 'package:web_gallery/pages/pagenotfound.dart';
import 'package:web_gallery/providers/page_notifier.dart';
import 'package:web_gallery/routes/routes.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final PageNotifier notifier;

  AppRouterDelegate({required this.notifier});

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          if (notifier.isUnknown) const MaterialPage(child: PageNotFound()),
          if (!notifier.isUnknown) const MaterialPage(child: HomePage()),
          if (notifier.pageName == PageName.HOME)
            const MaterialPage(child: HomePage()),
          if (notifier.pageName == PageName.CONTACT)
            const MaterialPage(child: ContactPage()),
          if (notifier.pageName == PageName.NOTIFICATION)
            const MaterialPage(child: NotificationPage()),
        ],
        onPopPage: (route, result) => route.didPop(result));
  }

  @override
  AppRoute? get currentConfiguration {
    if (notifier.isUnknown) {
      return AppRoute.unknown();
    }

    if (notifier.pageName == PageName.HOME) {
      return AppRoute.home();
    }

    if (notifier.pageName == PageName.NOTIFICATION) {
      return AppRoute.notiifcation();
    }

    if (notifier.pageName == PageName.CONTACT) {
      return AppRoute.contact();
    }

    return AppRoute.unknown();
  }

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    if (configuration.isNotification) {
      _updateRoute(page: PageName.NOTIFICATION);
    }

    if (configuration.isContact) {
      _updateRoute(page: PageName.CONTACT);
    }

    if (configuration.isHome) {
      _updateRoute(page: PageName.HOME);
    }
  }

  _updateRoute({PageName? page, bool isUnknown = false}) {
    notifier.changePage(page: page, unknown: isUnknown);
  }
}
