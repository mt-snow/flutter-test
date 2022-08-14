import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class VisibilityDetactableListItem extends StatefulWidget {
  const VisibilityDetactableListItem(
      {Key? key, required this.listViewKey, required this.controller})
      : super(key: key);
  final GlobalKey listViewKey;
  final ScrollController controller;

  @override
  State<VisibilityDetactableListItem> createState() =>
      _VisibilityDetactableListItemState();
}

class _VisibilityDetactableListItemState
    extends State<VisibilityDetactableListItem> {
  bool _detected = false;
  final wordPair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: const TextStyle(fontSize: 18),
      ),
      tileColor: _detected ? Colors.yellow : Colors.white,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.addListener(_onScroll));
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_onScroll);
  }

  void _onScroll() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final listViewRenderBox =
        widget.listViewKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null || listViewRenderBox == null) return;

    final listItemBottomPosition =
        renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height;
    final listViewBottomPosition =
        listViewRenderBox.localToGlobal(Offset.zero).dy +
            listViewRenderBox.size.height;
    if (listItemBottomPosition <= listViewBottomPosition && !_detected) {
      setState(() {
        _detected = true;
      });
    }
  }
}
