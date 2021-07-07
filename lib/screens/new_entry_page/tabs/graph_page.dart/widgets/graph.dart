import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class MyDrawGraph extends StatelessWidget {
  MyDrawGraph({Key? key, required this.exerciseLog}) : super(key: key);
  final List<ExerciseLog> exerciseLog;

  @override
  Widget build(BuildContext context) {
    var referenceBox;

    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        context
            .read(detailsProvider)
            .setOffset(referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();

        context
            .read(detailsProvider)
            .setOffset(referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();

        context
            .read(detailsProvider)
            .setOffset(referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanEnd: (details) {
        context.read(detailsProvider).setOffset(null);
      },
      onPanCancel: () {
        context.read(detailsProvider).setOffset(null);
      },
      child: Consumer(
        builder: (context, watch, child) {
          final details = watch(detailsProvider);
          final _graphEntries = watch(graphEntriesStream);
          return _graphEntries.when(
            data: (data) => CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: DrawGraph(
                tappedEntryIndex: details.comperOffset(
                  data,
                  MediaQuery.of(context).size.width,
                ),
                entries: data,
                lineColor: Theme.of(context).accentColor,
              ),
            ),
            loading: () => CenterProgressIndicator(),
            error: (e, __) => Text("error on graph entries: $e"),
          );
        },
      ),
    );
  }
}
