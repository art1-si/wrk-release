import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';

import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_listTile.dart';

class ExerciseSelectorPage extends StatefulWidget {
  final String exercisesType;

  ExerciseSelectorPage({Key? key, required this.exercisesType})
      : super(key: key);
  @override
  _ExerciseSelectorPageState createState() => _ExerciseSelectorPageState();
}

class _ExerciseSelectorPageState extends State<ExerciseSelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "${widget.exercisesType} Exercises",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: StreamBuilder(
        stream: null, //TODO:
        builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("notata");
            return Text("NO DATA");
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, int index) {
              print("List builder ");
              return ExerciseListTile(
                exerciseName: "${snapshot.data![index].exerciseName}",
                index: index,
                typeSnapshot: snapshot.data!,
              );
            },
          );
        },
      ),
    );
  }
}
