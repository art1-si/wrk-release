import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/services/strings.dart';
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
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => SizedBox(
            height: 8,
          ),
          itemCount: model.length,
          itemBuilder: (context, i) {
            return GestureDetector(
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
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          model[i].title,
                          style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 1.25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model[i].data.length,
                    itemBuilder: (context, index) {
                      final data = model[i].data[index];
                      return _TableItem(
                        showRPEfield: true,
                        middleField: "${Strings.weight}: ${data.weight}",
                        leftField: "${Strings.setString}: ${data.setCount}",
                        rightField: "${Strings.reps}: ${data.reps}",
                        rpeField: "${Strings.rpe}: ${data.exerciseRPE}",
                      );
                    },
                  ),
                ],
              ),
            );
          },
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
      width: width - 1,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
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
          color: Theme.of(context).primaryColor,
        ),
        //set
        _rowField(
          width: size.width / numberOfFields - 24,
          text: leftField,
        ),
        //reps
        Container(
          width: 1,
          height: 24,
          color: Theme.of(context).primaryColor,
        ),
        _rowField(
          width: size.width / numberOfFields - 24,
          text: rightField,
        ),
        //weight
        Container(
          width: 1,
          height: 24,
          color: Theme.of(context).primaryColor,
        ),
        _rowField(
          width: size.width / numberOfFields + 72,
          text: middleField,
        ),

        //RPE
        if (showRPEfield)
          Container(
            width: 1,
            height: 24,
            color: Theme.of(context).primaryColor,
          ),
        _rowField(
          width: size.width / numberOfFields - 24,
          text: rpeField!,
        ),
      ],
    );
  }
}
