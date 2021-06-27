import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';

class EntriesTableModel {
  EntriesTableModel({required this.title, required this.data});
  final String title;
  final List<ExerciseLog> data;
}

class EntriesTable extends StatelessWidget {
  const EntriesTable({Key? key, required this.model}) : super(key: key);
  final EntriesTableModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(model.title),
        ListView.builder(
          itemCount: model.data.length,
          itemBuilder: (context, index) {
            final data = model.data[index];
            return Row(
              children: [
                Text(data.setCount.toString()),
                Text(data.reps.toString()),
                Text(data.weight.toString()),
              ],
            );
          },
        ),
      ],
    );
  }
}
