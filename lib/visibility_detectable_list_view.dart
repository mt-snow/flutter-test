import 'package:flutter/material.dart';
import 'visibility_detectable_list_item.dart';

class VisibilityDetectableListView extends StatefulWidget {
  const VisibilityDetectableListView({Key? key}) : super(key: key);

  @override
  State<VisibilityDetectableListView> createState() =>
      _VisibilityDetectableListViewState();
}

class _VisibilityDetectableListViewState
    extends State<VisibilityDetectableListView> {
  final scrollController = ScrollController();
  final listViewKey = GlobalKey<_VisibilityDetectableListViewState>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        key: listViewKey,
        controller: scrollController,
        itemBuilder: (_, index) => VisibilityDetactableListItem(
            listViewKey: listViewKey, controller: scrollController),
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemCount: 100);
  }
}
