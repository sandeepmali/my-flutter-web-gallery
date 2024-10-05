enum PageName { HOME, CONTACT, NOTIFICATION }

class AppRoute {
  final PageName? pageName;
  final bool _isUnknown;

  AppRoute.home()
      : pageName = PageName.HOME,
        _isUnknown = false;

  AppRoute.contact()
      : pageName = PageName.CONTACT,
        _isUnknown = false;

  AppRoute.notiifcation()
      : pageName = PageName.NOTIFICATION,
        _isUnknown = false;

  AppRoute.unknown()
      : pageName = null,
        _isUnknown = false;

//Used to get the current path
  bool get isHome => pageName == PageName.HOME;

  bool get isNotification => pageName == PageName.NOTIFICATION;

  bool get isContact => pageName == PageName.CONTACT;

  bool get isUnknown => _isUnknown;
}
