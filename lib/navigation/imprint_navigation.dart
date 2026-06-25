import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/views/imprint.dart';

class ImprintNavigator extends StatefulWidget {
  final Function(GlobalKey<NavigatorState>) onRoutechange;
  const ImprintNavigator({super.key, required this.onRoutechange});

  @override
  ImprintNavigatorState createState() => ImprintNavigatorState();
}

GlobalKey<NavigatorState> updatesNavigatorKey = GlobalKey<NavigatorState>();

class ImprintNavigatorState extends State<ImprintNavigator> {
  @override
  void didChangeDependencies() {
    widget.onRoutechange(updatesNavigatorKey);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: updatesNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (settings.name == "/") {
              return const ImprintView();
            }
            return const ImprintView();
          },
        );
      },
    );
  }
}
