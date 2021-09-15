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
                return Container(
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              model[i].title,
                              style: TextStyle(
                                fontSize: 18.0,
                                letterSpacing: 1.25,
                              ),
                            ),
                          ),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model[i].data.length,
                          itemBuilder: (context, index) {
                            final data = model[i].data[index];
                            return _TableItem(
                              showRPEfield: true,
                              middleField: "${Strings.weight}: ${data.weight}",
                              leftField:
                                  "${Strings.setString}: ${data.setCount}",
                              rightField: "${Strings.reps}: ${data.reps}",
                              rpeField: "${Strings.rpe}: ${data.exerciseRPE}",
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            height: 0,
                            color: AppTheme.of(context).divider,
                          ),
                        ),
                      ],
                    ),
                  ),
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
      height: 30,
      width: width - 1,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 0.2,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),
        //set
        _rowField(
          width: size.width / numberOfFields - 28,
          text: leftField,
        ),
        //reps
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),
        _rowField(
          width: size.width / numberOfFields + 64,
          text: middleField,
        ),

        //weight
        Container(
          width: 1,
          height: 24,
          color: AppTheme.of(context).primary,
        ),

        _rowField(
          width: size.width / numberOfFields - 28,
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
          width: size.width / numberOfFields - 28,
          text: rpeField!,
        ),
      ],
    );
  }
}
