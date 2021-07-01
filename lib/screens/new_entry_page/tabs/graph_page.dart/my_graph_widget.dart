import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/line_divider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/my_graph_widget.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/onPressDialog.dart';
import 'package:workout_notes_app/services/logics.dart';

import 'dart:ui' as ui;

class MyGraphWidget extends ConsumerWidget {
  final List<ExerciseLog> exerciseLog;
  MyGraphWidget({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _graphProvider = watch(graphProvider(exerciseLog));

    if (_graphProvider.exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    return Column(
      children: [
        OnPressDialog(
          weight: 2,
          reps: 2,
          dateCreated: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 4,
                right: 0.0,
                top: 8,
              ),
              child: Stack(
                children: [
                  LineDividers(
                    dividerColor: Theme.of(context).dividerColor,
                    minWeightValue: _graphProvider.minValue,
                    maxWeightValue: _graphProvider.maxValue,
                    entryLength: exerciseLog.length,
                  ),
                  MyDrawGraph(
                    snapshotToPass: _graphProvider.exerciseLog,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
