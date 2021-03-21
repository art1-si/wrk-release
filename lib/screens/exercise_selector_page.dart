import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/provider/exercise_streams.dart';
import 'package:workout_notes_app/provider/plans_stream.dart';
import 'package:workout_notes_app/widgets/exercise_listTile.dart';

class ExerciseSelectorPage extends StatefulWidget {
  final String exercisesType;

  ExerciseSelectorPage({Key key, this.exercisesType}) : super(key: key);
  @override
  _ExerciseSelectorPageState createState() => _ExerciseSelectorPageState();
}

class _ExerciseSelectorPageState extends State<ExerciseSelectorPage> {
  WorkoutPlanStreams planStream = WorkoutPlanStreams();
  ExerciseStreams exerciseStreams = ExerciseStreams();

  @override
  void dispose() {
    exerciseStreams.dispose();
    planStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    exerciseStreams.addExercisesByTypeToStream(widget.exercisesType);
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
        stream: exerciseStreams.exerciseByTypeStream,
        builder: (context, AsyncSnapshot<List<ExerciseModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            print("notata");
            return Text("NO DATA");
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              print("List builder ");
              return ExerciseListTile(
                exerciseName: "${snapshot.data[index].exerciseName}",
                index: index,
                typeSnapshot: snapshot.data,
                planStream: planStream,
              );
            },
          );
        },
      ),
    );
  }
}
