import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/graph.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/onPressDialog.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/proerties_drop_down_menu.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class MyGraphWidget extends ConsumerWidget {
  final List<ExerciseLog> exerciseLog;
  MyGraphWidget({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _graphEntries = watch(graphEntriesStream);

    if (exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    return _graphEntries.when(
      data: (data) {
        context.read(detailsProvider).points = data;
        return _BodyContent(
          data: data,
        );
      },
      error: (e, __) => Text("SOMETHING WENT WRONG\n$e"),
      loading: () => CenterProgressIndicator(),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({Key? key, required this.data}) : super(key: key);
  final List<GraphModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnPressDialog(),
        PropertiesDropDown(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 4,
                right: 0.0,
                top: 8,
              ),
              child: MyDrawGraph(
                exerciseLog: data,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
