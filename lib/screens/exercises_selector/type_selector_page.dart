import 'package:flutter/material.dart';
import 'package:workout_notes_app/app.dart';
import 'package:workout_notes_app/data_models/exercise.dart';

import 'package:workout_notes_app/screens/exercises_selector/exercise_selector_page.dart.copy';
import 'package:workout_notes_app/screens/plan_page/widget/workout_listTile.dart';
import 'package:workout_notes_app/services/database.dart';

class TypeSelectorPage extends StatelessWidget {
  const TypeSelectorPage({
    Key? key,
  }) : super(key: key);
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
        stream: null, //TODO
        builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, int index) {
              return WorkoutListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExerciseSelectorPage(
                          exercisesType:
                              "${snapshot.data![index].exerciseType}")));
                },
                title: Text("${snapshot.data![index].exerciseType}",
                    style: Theme.of(context).textTheme.headline6),
              );
            },
          );
        },
      ),
    );
  }
}
