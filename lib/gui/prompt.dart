import 'dart:math';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:prompt_creator_flutter_app/helpers/app_db.dart';
import 'package:prompt_creator_flutter_app/helpers/vars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class PromptCreator extends StatefulWidget {
  const PromptCreator({super.key});

  @override
  State<PromptCreator> createState() => _PromptCreatorState();
}

class _PromptCreatorState extends State<PromptCreator> {
  String prompt = "";
  int numberOfPrompts = 0;
  IconData copyIcon = TablerIcons.copy;
  int _count = 0;

  bool hasPrevious = false;

  TextScaler scaler = TextScaler.linear(1.0);

  @override
  void initState() {
    hasPreviousCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scaler = MediaQuery.textScalerOf(context);
    return Row(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomScrollView(
                            physics: BouncingScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  Column(
                                    spacing: 16.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Boys Love Story Prompt Creator',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: scaler.scale(32.0),
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              createPrompt();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    6.0,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0,
                                                    ),
                                                child: Text(
                                                  "Create new",
                                                  style: TextStyle(
                                                    fontSize: scaler.scale(
                                                      18.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (hasPrevious)
                                            GestureDetector(
                                              onTap: () {
                                                hasPreviousCheck().then((v) {
                                                  showPreviousPrompts();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Text(
                                                    "Show previous",
                                                    style: TextStyle(
                                                      fontSize: scaler.scale(
                                                        18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (prompt.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              border: Border(
                                                left: BorderSide(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                                  width: 16.0,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(
                                                prompt,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'YuseiMagic',
                                                  fontSize: scaler.scale(32.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (prompt.isNotEmpty)
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          runAlignment: WrapAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                String post =
                                                    "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                                                Uri postEncoded = Uri.parse(
                                                  "https://twitter.com/intent/tweet?text=$post&via=sarerunet",
                                                );
                                                shareUrl(postEncoded);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Icon(
                                                    TablerIcons
                                                        .brand_twitter_filled,
                                                    size: scaler.scale(22.0),
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSecondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                String post =
                                                    "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                                                Uri postEncoded = Uri.parse(
                                                  "https://bsky.app/intent/compose?text=$post&via=sareru.net",
                                                );
                                                shareUrl(postEncoded);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Icon(
                                                    TablerIcons.brand_bluesky,
                                                    size: scaler.scale(22.0),
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSecondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                String post =
                                                    "My Boys Love prompt is:\n\n\"$prompt\"";
                                                Uri post_encoded = Uri.parse(
                                                  "https://www.tumblr.com/widgets/share/tool?posttype=link&caption=$post&content=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&canonicalUrl=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&tags=writers on tumblr,creative writing,writing prompt,yaoi prompt,boys love prompt",
                                                );
                                                shareUrl(post_encoded);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Icon(
                                                    TablerIcons.brand_tumblr,
                                                    size: scaler.scale(22.0),
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSecondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                String post =
                                                    "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!";
                                                Uri post_encoded = Uri.parse(
                                                  "mailto:?body=$post&subject=My Boys Love Prompt",
                                                );
                                                shareUrl(post_encoded);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Icon(
                                                    TablerIcons.mail,
                                                    size: scaler.scale(22.0),
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSecondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                String post =
                                                    "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                                                Clipboard.setData(
                                                  ClipboardData(text: post),
                                                ).then((value) {
                                                  setState(() {
                                                    copyIcon =
                                                        TablerIcons.checks;
                                                    _count++;
                                                  });
                                                  Future.delayed(
                                                    const Duration(
                                                      milliseconds: 600,
                                                    ),
                                                  ).then((value) {
                                                    setState(() {
                                                      copyIcon =
                                                          TablerIcons.copy;
                                                      _count++;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              6.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0,
                                                      ),
                                                  child: Row(
                                                    spacing: 8.0,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      AnimatedSwitcher(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 200,
                                                            ),
                                                        child: Icon(
                                                          copyIcon,
                                                          size: scaler.scale(
                                                            20.0,
                                                          ),
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                          key: ValueKey<int>(
                                                            _count,
                                                          ),
                                                        ),
                                                        transitionBuilder:
                                                            (child, animation) {
                                                              return ScaleTransition(
                                                                scale:
                                                                    animation,
                                                                child: child,
                                                              );
                                                            },
                                                      ),
                                                      Text(
                                                        "Copy",
                                                        style: TextStyle(
                                                          fontSize: scaler
                                                              .scale(18.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outlineVariant,
                                    width: 3.0,
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Imprint",
                                          style: TextStyle(
                                            fontSize: scaler.scale(20.0),
                                          ),
                                        ),
                                        Text(
                                          "Dominique Bauer",
                                          textScaler: scaler,
                                        ),
                                        Text("Austr. 11", textScaler: scaler),
                                        Text(
                                          "67378 Zeiskam",
                                          textScaler: scaler,
                                        ),
                                        Text("Germany", textScaler: scaler),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 4.0,
                                          children: [
                                            Icon(
                                              TablerIcons.at,
                                              size: scaler.scale(16.0),
                                            ),
                                            Text(
                                              "dom@rottendev.net",
                                              textScaler: scaler,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6.0),
                                ),
                                border: Border(
                                  left: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outlineVariant,
                                    width: 3.0,
                                  ),
                                  bottom: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outlineVariant,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Imprint",
                                  style: TextStyle(
                                    fontSize: scaler.scale(18.0),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

  int getRandomInt(max) {
    return Random().nextInt(max);
  }

  void createPrompt() {
    String newPrompt = "";
    String promptTraita = traits[getRandomInt(traits.length)];
    String promptTraitb = traits[getRandomInt(traits.length)];
    String promptJoba = jobs[getRandomInt(jobs.length)];
    String promptJobb = jobs[getRandomInt(jobs.length)];
    String promptAction = actions[getRandomInt(actions.length)];
    String promptPlace = places[getRandomInt(places.length)];

    newPrompt = "A";
    if (['a', 'i', 'u', 'e', 'o'].contains(promptTraita.characters.first)) {
      newPrompt += "n";
    }
    newPrompt += " $promptTraita $promptJoba and a";
    if (['a', 'i', 'u', 'e', 'o'].contains(promptTraitb.characters.first)) {
      newPrompt += "n";
    }
    newPrompt += " $promptTraitb $promptJobb $promptAction $promptPlace.";
    setState(() {
      prompt = newPrompt;
      hasPrevious = true;
    });

    final now = DateTime.now();
    db.addPrompt(
      PromptsCompanion(prompt: Value(newPrompt), createdAt: Value(now)),
    );
  }

  void showPreviousPrompts() async {
    List<Prompt> prompts = await db.getAllPrompts();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              Text(
                "List of previous prompts",
                style: TextStyle(
                  fontSize: scaler.scale(20.0),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                "$numberOfPrompts prompt(s) total",
                style: TextStyle(
                  fontSize: scaler.scale(14.0),
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: 'YuseiMagic',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: prompts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onLongPress: () {
                        showShareDialog(prompts[index].prompt);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border(
                              left: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 8.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  prompts[index].prompt,
                                  style: TextStyle(
                                    fontFamily: "YuseiMagic",
                                    fontSize: scaler.scale(18.0),
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'yyyy-MM-dd HH:mm',
                                  ).format(prompts[index].createdAt),
                                  style: TextStyle(
                                    fontSize: scaler.scale(14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDeleteAllDialog();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Delete all",
                          style: TextStyle(fontSize: scaler.scale(20.0)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
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
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: scaler.scale(20.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              GestureDetector(
                onTap: () {
                  deleteAllPrompts();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Delete all prompts',
                      style: TextStyle(
                        fontSize: scaler.scale(20.0),
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Abort',
                      style: TextStyle(fontSize: scaler.scale(20.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showShareDialog(String prompt) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              GestureDetector(
                onTap: () {
                  String post =
                      "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                  Uri postEncoded = Uri.parse(
                    "https://twitter.com/intent/tweet?text=$post&via=sarerunet",
                  );
                  shareUrl(postEncoded);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Icon(
                      TablerIcons.brand_twitter_filled,
                      size: scaler.scale(18.0),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String post =
                      "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                  Uri postEncoded = Uri.parse(
                    "https://bsky.app/intent/compose?text=$post&via=sareru.net",
                  );
                  shareUrl(postEncoded);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Icon(
                      TablerIcons.brand_bluesky,
                      size: scaler.scale(18.0),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String post = "My Boys Love prompt is:\n\n\"$prompt\"";
                  Uri post_encoded = Uri.parse(
                    "https://www.tumblr.com/widgets/share/tool?posttype=link&caption=$post&content=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&canonicalUrl=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&tags=writers on tumblr,creative writing,writing prompt,yaoi prompt,boys love prompt",
                  );
                  shareUrl(post_encoded);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Icon(
                      TablerIcons.brand_tumblr,
                      size: scaler.scale(18.0),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String post =
                      "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!";
                  Uri post_encoded = Uri.parse(
                    "mailto:?body=$post&subject=My Boys Love Prompt",
                  );
                  shareUrl(post_encoded);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Icon(
                      TablerIcons.mail,
                      size: scaler.scale(18.0),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String post =
                      "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                  Clipboard.setData(ClipboardData(text: post)).then((value) {
                    setState(() {
                      copyIcon = TablerIcons.checks;
                      _count++;
                    });
                    Future.delayed(const Duration(milliseconds: 600)).then((
                      value,
                    ) {
                      setState(() {
                        copyIcon = TablerIcons.copy;
                        _count++;
                      });
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      spacing: 8.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            copyIcon,
                            size: scaler.scale(18.0),
                            color: Theme.of(context).colorScheme.onSecondary,
                            key: ValueKey<int>(_count),
                          ),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                        ),
                        Text("Copy", textScaler: scaler),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> hasPreviousCheck() async {
    db.getLatestPrompt().then((prompt) {
      if (prompt != null) {
        setState(() {
          this.prompt = prompt.prompt;
          hasPrevious = true;
        });
      } else {
        setState(() {
          this.prompt = "";
          hasPrevious = false;
        });
      }
    });

    db.getNumberOfPrompts().then((count) {
      if (count != null) {
        setState(() {
          numberOfPrompts = count;
        });
      }
    });
  }

  void deleteAllPrompts() {
    db.deleteAllPrompts();
    hasPreviousCheck();
  }

  Future<void> shareUrl(Uri uri) async {
    // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    print('Could not launch $uri');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              Text(
                'Something went wrong, please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: scaler.scale(20.0)),
              ),
              Text(
                'Tried to launch URL: $uri',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: scaler.scale(14.0)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: scaler.scale(20.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}
