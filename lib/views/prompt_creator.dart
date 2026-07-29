import 'dart:math';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:prompt_creator_flutter_app/helpers/app_db.dart';
import 'package:prompt_creator_flutter_app/helpers/functions.dart';
import 'package:prompt_creator_flutter_app/helpers/vars.dart';
import 'package:flutter/services.dart';
import 'package:prompt_creator_flutter_app/views/imprint.dart';

class PromptCreatorView extends StatefulWidget {
  const PromptCreatorView({super.key});

  @override
  State<PromptCreatorView> createState() => _PromptCreatorViewState();
}

class _PromptCreatorViewState extends State<PromptCreatorView> {
  String promptText = "";
  Prompt? prompt;
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
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.all(16.0)),
                          Expanded(
                            child: Text(
                              'Boys Love Story Prompt Creator',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: scaler.scale(32.0),
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showImprint();
                            },
                            icon: Icon(TablerIcons.info_circle),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        createPrompt();
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
                            "Create new",
                            style: TextStyle(
                              fontSize: scaler.scale(18.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (promptText.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/view',
                            arguments: {'prompt': prompt},
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                promptText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'YuseiMagic',
                                  fontSize: scaler.scale(32.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (promptText.isNotEmpty)
                      Text(
                        'Share your prompt',
                        textScaler: scaler,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    if (promptText.isNotEmpty)
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        runAlignment: WrapAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              String post =
                                  "My Boys Love prompt is:\n\n\"$promptText\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                              Uri postEncoded = Uri.parse(
                                "https://twitter.com/intent/tweet?text=$post&via=sarerunet",
                              );
                              shareUrl(postEncoded, context, scaler);
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
                                  "My Boys Love prompt is:\n\n\"$promptText\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                              Uri postEncoded = Uri.parse(
                                "https://bsky.app/intent/compose?text=$post&via=sareru.net",
                              );
                              shareUrl(postEncoded, context, scaler);
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
                                  "My Boys Love prompt is:\n\n\"$promptText\"";
                              Uri postEncoded = Uri.parse(
                                "https://www.tumblr.com/widgets/share/tool?posttype=link&caption=$post&content=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&canonicalUrl=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&tags=writers on tumblr,creative writing,writing prompt,yaoi prompt,boys love prompt",
                              );
                              shareUrl(postEncoded, context, scaler);
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
                                  "My Boys Love prompt is:\n\n\"$promptText\"\n\nGet your prompt at https://sareru.net/promptcreator/!";
                              Uri postEncoded = Uri.parse(
                                "mailto:?body=$post&subject=My Boys Love Prompt",
                              );
                              shareUrl(postEncoded, context, scaler);
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
                                  "My Boys Love prompt is:\n\n\"$promptText\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                              Clipboard.setData(ClipboardData(text: post)).then(
                                (value) {
                                  setState(() {
                                    copyIcon = TablerIcons.checks;
                                    _count++;
                                  });
                                  Future.delayed(
                                    const Duration(milliseconds: 600),
                                  ).then((value) {
                                    setState(() {
                                      copyIcon = TablerIcons.copy;
                                      _count++;
                                    });
                                  });
                                },
                              );
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
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Icon(
                                        copyIcon,
                                        size: scaler.scale(20.0),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                        key: ValueKey<int>(_count),
                                      ),
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                    Text(
                                      "Copy",
                                      style: TextStyle(
                                        fontSize: scaler.scale(18.0),
                                        fontWeight: FontWeight.bold,
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
      promptText = newPrompt;
      hasPrevious = true;
    });

    final now = DateTime.now();
    db
        .addPrompt(
          PromptsCompanion(prompt: Value(newPrompt), createdAt: Value(now)),
        )
        .then(
          (onValue) => {
            db.getLatestPrompt().then(
              (latestPrompt) => {
                setState(() {
                  prompt = latestPrompt;
                }),
              },
            ),
          },
        );
  }

  void showImprint() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: Border.all(
          color: Theme.of(dialogContext).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(dialogContext).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImprintView(),
        ),
      ),
    );
  }

  Future<void> hasPreviousCheck() async {
    db.getLatestPrompt().then((prompt) {
      if (prompt != null) {
        setState(() {
          this.prompt = prompt;
          promptText = prompt.prompt;
          hasPrevious = true;
        });
      } else {
        setState(() {
          promptText = "";
          hasPrevious = false;
        });
      }
    });
  }
}
