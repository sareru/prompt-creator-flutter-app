import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:prompt_creator_flutter_app/helpers/app_db.dart';
import 'package:prompt_creator_flutter_app/helpers/functions.dart';

class PromptList extends StatefulWidget {
  const PromptList({super.key});

  @override
  State<PromptList> createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> {
  List<Prompt> prompts = [];
  int numberOfPrompts = 0;
  TextScaler scaler = TextScaler.linear(1.0);
  IconData copyIcon = TablerIcons.copy;
  int _count = 0;
  TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    searchPrompts();
    super.didChangeDependencies();
  }

  void searchPrompts() {
    db.searchPrompts(controller.text).then((onValue) {
      setState(() {
        prompts = onValue;
      });
    });

    db.getNumberOfPrompts().then((count) {
      if (count != null) {
        setState(() {
          numberOfPrompts = count;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scaler = MediaQuery.textScalerOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: const EdgeInsets.all(8.0)),
            Text(
              "List of previous prompts",
              style: TextStyle(
                fontSize: scaler.scale(20.0),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                searchPrompts();
              },
              icon: Icon(TablerIcons.refresh),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                Text(
                  "$numberOfPrompts prompt(s) total",
                  style: TextStyle(
                    fontSize: scaler.scale(14.0),
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'YuseiMagic',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) async {
                      searchPrompts();
                    },
                    decoration: InputDecoration(hint: Text('Search prompts')),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    itemCount: prompts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/view',
                            arguments: {'prompt': prompts[index]},
                          ).then((onValue) {
                            searchPrompts();
                            print('back');
                          });
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
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
              ],
            ),
          ),
        ),
      ],
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

  void deleteAllPrompts() {
    db.deleteAllPrompts();
  }
}
