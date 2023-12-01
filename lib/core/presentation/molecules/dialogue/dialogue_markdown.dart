import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/presentation/molecules/dialogue/dialogue_base.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DialogueMarkdown extends StatelessWidget {
  final String title;

  ///MarkDown Body
  final String? body;

  const DialogueMarkdown({
    Key? key,
    required this.title,
    this.body,
  }) : super(key: key);

  static show(
    BuildContext context, {
    Key? key,
    required String title,
    String body = '',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogueMarkdown(
          key: key,
          title: title,
          body: body,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogueBase(
      title: title,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MarkdownBody(
            selectable: true,
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              [
                md.EmojiSyntax(),
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
              ],
            ),
            data: body ?? '',
          ),
        ),
      ),
    );
  }
}
