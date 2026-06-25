import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/views/prompt_creator.dart';

class PromptNavigator extends StatefulWidget {
  final Function(GlobalKey<NavigatorState>) onRoutechange;
  const PromptNavigator({super.key, required this.onRoutechange});

  @override
  PromptNavigatorState createState() => PromptNavigatorState();
}

GlobalKey<NavigatorState> updatesNavigatorKey = GlobalKey<NavigatorState>();

class PromptNavigatorState extends State<PromptNavigator> {
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
            if (settings.name == "/details") {
              return const PromptCreatorView();
            }
            if (settings.name == "/") {
              return const PromptCreatorView();
            }
            return const PromptCreatorView();
          },
        );
      },
    );
  }
}
