import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void pushPage(Widget page, {Object? arguments}) => Navigator.push(
        this,
        MaterialPageRoute(
            builder: (_) => page,
            settings: RouteSettings(arguments: arguments)),
      );

  void pushNamedPage(String route, {Object? arguments}) =>
      Navigator.pushNamed(this, route, arguments: arguments);
  void pushReplacementNamedPage(String route) =>
      Navigator.pushReplacementNamed(this, route);
  void pushNamedAndRemoveUntilPage(String route, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(
          this, route, arguments: arguments, (route) => false);
  void pushNamedAndRemoveUntilPageSaveStack(String route) =>
      Navigator.pushNamedAndRemoveUntil(this, route, (route) => true);

  void popPage() => Navigator.pop(this);
}
