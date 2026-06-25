import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/navigation/imprint_navigation.dart';
import 'package:prompt_creator_flutter_app/navigation/list_navigation.dart';
import 'package:prompt_creator_flutter_app/navigation/nav_item_model.dart';
import 'package:prompt_creator_flutter_app/navigation/prompt_navigation.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  List<GlobalKey<NavigatorState>> keys = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.outline,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 8.0,
            children: List.generate(bottomNavItems.length, (i) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_selectedIndex == i && keys[i].currentState != null) {
                      keys[i].currentState!.popUntil(ModalRoute.withName('/'));
                    } else {
                      setState(() {
                        _selectedIndex = i;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == _selectedIndex
                          ? Theme.of(context).colorScheme.outlineVariant
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 3.0,
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        bottomNavItems[i].icon,
                        color: i == _selectedIndex
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: IndexedStack(
                            index: _selectedIndex,
                            children: <Widget>[
                              PromptNavigator(
                                onRoutechange: (key) {
                                  keys.add(key);
                                },
                              ),

                              PromptListNavigator(
                                onRoutechange: (key) {
                                  keys.add(key);
                                },
                              ),

                              ImprintNavigator(
                                onRoutechange: (key) {
                                  keys.add(key);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
