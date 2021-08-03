import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_point.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/line_divider.dart';

class MyDrawGraph extends StatelessWidget {
  MyDrawGraph({Key? key, required this.exerciseLog}) : super(key: key);
  final List<GraphModel> exerciseLog;

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          LinerGraph(
            exerciseLog: exerciseLog,
          ),
          Consumer(
            builder: (context, watch, child) {
              final tappedPosition = watch(detailsProvider).index;
              if (tappedPosition == null) {
                return Container();
              } else {
                return GraphPoint(
                  entry: exerciseLog[tappedPosition],
                );
              }
            },
          ),
          LineDividers(
            data: exerciseLog,
          ),
        ],
      ),
    );
  }
}
