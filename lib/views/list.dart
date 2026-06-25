import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/gui/prompt_list.dart';

class PromptListView extends StatefulWidget {
  const PromptListView({super.key});

  @override
  State<PromptListView> createState() => _PromptListViewState();
}

class _PromptListViewState extends State<PromptListView> {
  TextScaler scaler = TextScaler.linear(1.0);

  @override
  Widget build(BuildContext context) {
    scaler = MediaQuery.textScalerOf(context);

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: PromptList(),
    );
  }
}
