import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class MyDrawGraph extends StatelessWidget {
  const MyDrawGraph({Key? key, required this.exerciseLog}) : super(key: key);
  final List<ExerciseLog> exerciseLog;

  //GraphModel? tappedExerciseLog;

  @override
  Widget build(BuildContext context) {
    final _graphProvider = context.read(graphProvider);

    var referenceBox;

    _graphProvider.setTappedLog();
    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        _graphProvider.setPressedPosition(
            referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();

        _graphProvider.setPressedPosition(
            referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();

        _graphProvider.setPressedPosition(
            referenceBox!.globalToLocal(details.globalPosition));
      },
      onPanEnd: (details) {
        // _graphProvider.setPressedPosition(null);
      },
      onPanCancel: () {
        // _graphProvider.setPressedPosition(null);
      },
      child: Consumer(
        builder: (context, watch, child) {
          final _graphEntries = watch(graphEntriesStream);
          return _graphEntries.when(
            data: (data) => CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: DrawGraph(
                tappedEntryIndex: null,
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
