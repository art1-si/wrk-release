import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/chart_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/graph.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/onPressDialog.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/proerties_drop_down_menu.dart';

class MyGraphWidget extends StatelessWidget {
  final List<ExerciseLog> exerciseLog;
  MyGraphWidget({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    if (exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    return _BodyContent();
  }
}

class _BodyContent extends ConsumerWidget {
  const _BodyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final chartData = watch(chartViewProvider).graphPoints;
    context.read(detailsProvider).points = chartData;
    return ListView(
      children: [
        PropertiesDropDown(),
        OnPressDialog(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 4,
                right: 0.0,
                top: 16,
              ),
              child: MyDrawGraph(
                chartData: chartData!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
