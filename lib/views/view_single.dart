import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:prompt_creator_flutter_app/helpers/app_db.dart';
import 'package:prompt_creator_flutter_app/helpers/functions.dart';

class SinglePromptView extends StatefulWidget {
  const SinglePromptView({super.key});

  @override
  State<SinglePromptView> createState() => _SinglePromptViewState();
}

class _SinglePromptViewState extends State<SinglePromptView> {
  TextScaler scaler = TextScaler.linear(1.0);
  IconData copyIcon = TablerIcons.copy;
  IconData copyNotesIcon = TablerIcons.copy;
  IconData saveIcon = TablerIcons.check;
  Prompt? prompt;
  TextEditingController controller = TextEditingController();
  int _copyCount = 0;
  int _copyNotesCount = 0;
  int _saveCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    if (arguments['prompt'] == null) Navigator.pop(context);
    prompt = arguments['prompt'];
    controller.text = prompt!.notes ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    scaler = MediaQuery.textScalerOf(context);
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: prompt == null
          ? Container()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        TablerIcons.chevron_left,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "View prompt",
                      style: TextStyle(
                        fontSize: scaler.scale(20.0),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDeleteDialog(context);
                      },
                      icon: Icon(
                        TablerIcons.trash,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: CustomScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 8.0,
                              children: [
                                Text(
                                  DateFormat(
                                    'yyyy-MM-dd HH:mm',
                                  ).format(prompt!.createdAt),
                                  style: TextStyle(
                                    fontSize: scaler.scale(12.0),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontFamily: 'YuseiMagic',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
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
                                        prompt!.prompt,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'YuseiMagic',
                                          fontSize: scaler.scale(28.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                        shareUrl(postEncoded, context, scaler);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                            "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                                        Uri postEncoded = Uri.parse(
                                          "https://bsky.app/intent/compose?text=$post&via=sareru.net",
                                        );
                                        shareUrl(postEncoded, context, scaler);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                            "My Boys Love prompt is:\n\n\"$prompt\"";
                                        Uri postEncoded = Uri.parse(
                                          "https://www.tumblr.com/widgets/share/tool?posttype=link&caption=$post&content=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&canonicalUrl=https%3A%2F%2Fsareru.net%2Fpromptcreator%2F&tags=writers on tumblr,creative writing,writing prompt,yaoi prompt,boys love prompt",
                                        );
                                        shareUrl(postEncoded, context, scaler);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                            "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!";
                                        Uri postEncoded = Uri.parse(
                                          "mailto:?body=$post&subject=My Boys Love Prompt",
                                        );
                                        shareUrl(postEncoded, context, scaler);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                            "My Boys Love prompt is:\n\n\"$prompt\"\n\nGet your prompt at https://sareru.net/promptcreator/!\n#sarerusBLprompts";
                                        Clipboard.setData(
                                          ClipboardData(text: post),
                                        ).then((value) {
                                          setState(() {
                                            copyIcon = TablerIcons.checks;
                                            _copyCount++;
                                          });
                                          Future.delayed(
                                            const Duration(milliseconds: 600),
                                          ).then((value) {
                                            setState(() {
                                              copyIcon = TablerIcons.copy;
                                              _copyCount++;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                                  key: ValueKey<int>(
                                                    _copyCount,
                                                  ),
                                                ),
                                                transitionBuilder:
                                                    (child, animation) {
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
                                Padding(padding: const EdgeInsets.all(8.0)),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(6.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: TextField(
                                      maxLines: 5,
                                      style: TextStyle(
                                        fontFamily: 'YuseiMagic',
                                        fontSize: scaler.scale(16),
                                      ),
                                      decoration: InputDecoration(
                                        hint: Text('Notes'),
                                      ),
                                      controller: controller,
                                      onTapOutside: (event) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: controller.text),
                                        ).then((value) {
                                          setState(() {
                                            copyNotesIcon = TablerIcons.checks;
                                            _copyNotesCount++;
                                          });
                                          Future.delayed(
                                            const Duration(milliseconds: 600),
                                          ).then((value) {
                                            setState(() {
                                              copyNotesIcon = TablerIcons.copy;
                                              _copyNotesCount++;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                                  copyNotesIcon,
                                                  size: scaler.scale(18.0),
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSecondary,
                                                  key: ValueKey<int>(
                                                    _copyNotesCount,
                                                  ),
                                                ),
                                                transitionBuilder:
                                                    (child, animation) {
                                                      return ScaleTransition(
                                                        scale: animation,
                                                        child: child,
                                                      );
                                                    },
                                              ),
                                              Text(
                                                "Copy notes",
                                                textScaler: scaler,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        saveNotes();
                                        setState(() {
                                          saveIcon = TablerIcons.checks;
                                          _saveCount++;
                                        });
                                        Future.delayed(
                                          const Duration(milliseconds: 600),
                                        ).then((value) {
                                          setState(() {
                                            saveIcon = TablerIcons.check;
                                            _saveCount++;
                                          });
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
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
                                                  saveIcon,
                                                  size: scaler.scale(20.0),
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSecondary,
                                                  key: ValueKey<int>(
                                                    _saveCount,
                                                  ),
                                                ),
                                                transitionBuilder:
                                                    (child, animation) {
                                                      return ScaleTransition(
                                                        scale: animation,
                                                        child: child,
                                                      );
                                                    },
                                              ),
                                              Text(
                                                "Save notes",
                                                textScaler: scaler,
                                                style: TextStyle(
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
                ),
              ],
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
                      size: scaler.scale(18.0),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String post = "My Boys Love prompt is:\n\n\"$prompt\"";
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
                      _copyCount++;
                    });
                    Future.delayed(const Duration(milliseconds: 600)).then((
                      value,
                    ) {
                      setState(() {
                        copyIcon = TablerIcons.copy;
                        _copyCount++;
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
                            key: ValueKey<int>(_copyCount),
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

  void showDeleteDialog(BuildContext mainContext) {
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
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete prompt "${prompt!.prompt}"?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'YuseiMagic',

                  fontSize: scaler.scale(20.0),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  db.deletePrompt(prompt!.id).then((value) {
                    Navigator.of(context).pop();
                    Navigator.of(mainContext).pop('t');
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
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
                      'Delete',
                      style: TextStyle(
                        fontSize: scaler.scale(20.0),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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

  void saveNotes() {
    Prompt updatedPrompt = prompt!.copyWith(notes: Value(controller.text));
    db.updatePrompt(updatedPrompt).then((bool result) {
      if (!result) {
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
              child: Text("Something went wrong. Please try again."),
            ),
          ),
        );
      }
    });
  }
}
