import 'package:clean_architecture_sample/presentation/screen/user/search.dart';
import 'package:flutter/material.dart';

class Routes {
  static const userSearchRoute = '/usersearch';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/usersearch':
        return MaterialPageRoute(builder: (_) => UserSearch());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
