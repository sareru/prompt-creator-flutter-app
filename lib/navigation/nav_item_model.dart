import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class NavItemModel {
  final String title;
  final IconData icon;
  final IconData iconSelected;

  NavItemModel({
    required this.title,
    required this.icon,
    required this.iconSelected,
  });
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: 'Prompt Creator',
    icon: TablerIcons.home,
    iconSelected: TablerIcons.home_filled,
  ),
  NavItemModel(
    title: 'Prompt List',
    icon: TablerIcons.list_search,
    iconSelected: TablerIcons.list_search,
  ),
  NavItemModel(
    title: 'Imprint',
    icon: TablerIcons.question_mark,
    iconSelected: TablerIcons.question_mark,
  ),
];
