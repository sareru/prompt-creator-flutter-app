import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/views/list.dart';
import 'package:prompt_creator_flutter_app/views/prompt_creator.dart';
import 'package:prompt_creator_flutter_app/views/view_single.dart';

class PromptListNavigator extends StatefulWidget {
  final Function(GlobalKey<NavigatorState>) onRoutechange;
  const PromptListNavigator({super.key, required this.onRoutechange});

  @override
  PromptListNavigatorState createState() => PromptListNavigatorState();
}

GlobalKey<NavigatorState> updatesNavigatorKey = GlobalKey<NavigatorState>();

class PromptListNavigatorState extends State<PromptListNavigator> {
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
            if (settings.name == "/view") {
              return const SinglePromptView();
            }
            return const PromptListView();
          },
        );
      },
    );
  }
}
