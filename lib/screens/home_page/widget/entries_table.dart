import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/services/strings.dart';

class EntriesTable extends StatelessWidget {
  const EntriesTable({Key? key, required this.model}) : super(key: key);
  final List<GroupByModel<ExerciseLog>> model;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(
              height: 8,
            ),
        itemCount: model.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
          );
        });
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
      width: width,
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
        _rowField(
          width: size.width / numberOfFields,
          text: leftField,
        ),
        _rowField(
          width: size.width / numberOfFields,
          text: middleField,
        ),
        _rowField(
          width: size.width / numberOfFields,
          text: rightField,
        ),
        if (showRPEfield)
          _rowField(
            width: size.width / numberOfFields,
            text: rpeField!,
          ),
      ],
    );
  }
}
