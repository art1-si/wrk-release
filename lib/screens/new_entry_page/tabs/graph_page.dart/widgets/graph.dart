import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class MyDrawGraph extends ConsumerWidget {
  MyDrawGraph({Key? key, required this.exerciseLog}) : super(key: key);
  final List<ExerciseLog> exerciseLog;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final details = watch(detailsProvider);
    final _graphEntries = watch(graphEntriesStream);
    var referenceBox;

    return _graphEntries.when(
      data: (data) {
        details.points = data;
        details.width = MediaQuery.of(context).size.width;
        return GestureDetector(
          onPanDown: (details) {
            print("onPanDown");
            referenceBox = context.findRenderObject();
            context
                .read(detailsProvider)
                .setOffset(referenceBox!.globalToLocal(details.globalPosition));
          },
          onPanStart: (details) {
            print("onPan Start");
            referenceBox = context.findRenderObject();

            context
                .read(detailsProvider)
                .setOffset(referenceBox!.globalToLocal(details.globalPosition));
          },
          onPanUpdate: (details) {
            print("onPan update");
            referenceBox = context.findRenderObject();

            context
                .read(detailsProvider)
                .setOffset(referenceBox!.globalToLocal(details.globalPosition));
          },
          onPanEnd: (details) {
            print("onPan end");
            context.read(detailsProvider).setOffset(null);
          },
          onPanCancel: () {
            print("onPan cancel");
            context.read(detailsProvider).setOffset(null);
          },
          child: CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: DrawGraph(
              tappedEntryIndex: details.index,
              entries: data,
              lineColor: Theme.of(context).accentColor,
            ),
          ),
        );
      },
      loading: () => CenterProgressIndicator(),
      error: (e, __) => Text("error on graph entries: $e"),
    );
  }
}
