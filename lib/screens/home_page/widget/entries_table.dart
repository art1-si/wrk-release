import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/constants/strings.dart';
import 'package:workout_notes_app/theme/app_theme.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class EntriesTable extends ConsumerWidget {
  const EntriesTable({
    Key? key,
    required this.model,
  }) : super(key: key);
  final List<GroupByModel<ExerciseLog>> model;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _exercises = watch(exerciseStream);
    return _exercises.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemCount: model.length,
              itemBuilder: (context, i) {
                return _Items(
                  itemContent: _ItemContent(
                    log: model[i].data,
                  ),
                  title: model[i].title,
                  onPressed: () {
                    context
                        .read(addExerciseLogProvider)
                        .selectExercisesWithoutNotify(data);
                    context
                        .read(addExerciseLogProvider)
                        .setExercisesToCorrespondingItems(model);
                    context
                        .read(addExerciseLogProvider)
                        .setSelectedExerciseIndex(i);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          /*  */
                          return AddExerciseToLog();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      error: (error, __) => Text("SOMETHING WENT WRONG \n$error"),
      loading: () => CenterProgressIndicator(),
    );
  }
}

class _Items extends StatelessWidget {
  const _Items({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.itemContent,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final _ItemContent itemContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context).primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.25,
                  ),
                ),
              ),
            ),
            itemContent,
          ],
        ),
      ),
    );
  }
}

class _ItemContent extends StatelessWidget {
  const _ItemContent({
    required this.log,
    Key? key,
  }) : super(key: key);
  final List<ExerciseLog> log;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: log.length * 25,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).divider,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 4,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              _TableItem(
                middleField: Strings.weight,
                leftField: Strings.setString,
                rightField: Strings.reps,
                rpeField: Strings.rpe,
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: log.length,
                itemBuilder: (context, index) {
                  final data = log[index];
                  return _TableItem(
                    showRPEfield: true,
                    middleField: "${data.weight}",
                    leftField: "${data.setCount}",
                    rightField: "${data.reps}",
                    rpeField: "${data.exerciseRPE}",
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0,
                  color: AppTheme.of(context).divider,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TableItem extends StatelessWidget {
  const _TableItem({
    Key? key,
    required this.middleField,
    required this.leftField,
    required this.rightField,
    this.showRPEfield = true,
    this.rpeField,
  }) : super(key: key);

  final bool showRPEfield;
  final String middleField;
  final String leftField;
  final String rightField;
  final String? rpeField;

  Widget _rowField({required double width, required String text}) {
    return SizedBox(
      height: 25,
      width: width - 1,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final numberOfFields = showRPEfield ? 4 : 3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),
        //set
        _rowField(
          width: size.width / numberOfFields * 0.3,
          text: leftField,
        ),
        //reps
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),
        _rowField(
          width: size.width / numberOfFields,
          text: middleField,
        ),

        //weight
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),

        _rowField(
          width: size.width / numberOfFields * 0.5,
          text: rightField,
        ),
        //RPE
        if (showRPEfield)
          Container(
            width: 1,
            height: 24,
            color: AppTheme.of(context).primary,
          ),
        _rowField(
          width: size.width / numberOfFields * 0.5,
          text: rpeField!,
        ),
      ],
    );
  }
}
