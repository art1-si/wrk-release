import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';

class MyDrawGraph extends ConsumerWidget {
  MyDrawGraph({Key? key, required this.exerciseLog}) : super(key: key);
  final List<GraphModel> exerciseLog;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final details = watch(detailsProvider);
    var _width = MediaQuery.of(context).size.width;
    var referenceBox;
    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        var _res = Offset(
            details.globalPosition.dx / _width, details.globalPosition.dy);
        context.read(detailsProvider).setOffset(_res);
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();
        var _res = Offset(
            details.globalPosition.dx / _width, details.globalPosition.dy);
        context.read(detailsProvider).setOffset(_res);
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();
        var _res = Offset(
            details.globalPosition.dx / _width, details.globalPosition.dy);
        context.read(detailsProvider).setOffset(_res);
      },
      onPanEnd: (details) {
        context.read(detailsProvider).setOffset(null);
      },
      onPanCancel: () {
        context.read(detailsProvider).setOffset(null);
      },
      child: CustomPaint(
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        painter: DrawGraph(
          tappedEntryIndex: details.index,
          entries: exerciseLog,
          lineColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
