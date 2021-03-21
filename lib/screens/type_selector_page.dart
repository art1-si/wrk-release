import 'package:flutter/material.dart';
import 'package:workout_notes_app/app.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/provider/exercise_streams.dart';
import 'package:workout_notes_app/screens/exercise_selector_page.dart';
import 'package:workout_notes_app/widgets/workout_listTile.dart';

class TypeSelectorPage extends StatelessWidget {
  final ExerciseStreams exerciseStreams = ExerciseStreams();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp())),
          child: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Exercisies Type",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: StreamBuilder(
        stream: exerciseStreams.exerciseTypeStream,
        builder: (context, AsyncSnapshot<List<ExerciseModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              return WorkoutListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExerciseSelectorPage(
                          exercisesType:
                              "${snapshot.data[index].exerciseType}")));
                },
                title: Text("${snapshot.data[index].exerciseType}",
                    style: Theme.of(context).textTheme.headline6),
              );
            },
          );
        },
      ),
    );
  }
}
