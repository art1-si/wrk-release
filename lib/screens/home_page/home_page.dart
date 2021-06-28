import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/exercises_selector/type_selector_page.dart';
import 'package:workout_notes_app/screens/home_page/widget/log_item_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/services/strings.dart';

class MyHomePage extends StatelessWidget {
  List<Widget> _header() {
    return <Widget>[
      const Divider(
        height: 20,
        color: Colors.transparent,
      ),
      const Divider(
        height: 40,
        color: Colors.transparent,
      ),
      const Divider(
        height: 12,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePage build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Workout Notes",
              style: Theme.of(context).textTheme.headline1,
            ),
            elevation: 0,
            expandedHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TypeSelectorPage(),
                      ),
                    );
                  },
                  child: Text(Strings.exercise),
                ),
                LogItemBuilder(),
                TextButton(
                  onPressed: () {
                    final database = context.read(databaseProvider);
                    final date = context.read(selectedDateProvider);
                    database.createExerciseLog(
                      ExerciseLog(
                        id: documentIdFromCurrentDate(),
                        exerciseID: "exerciseID2",
                        exerciseName: "exerciseName2",
                        exerciseType: "exerciseType2",
                        weight: 22,
                        reps: 1,
                        setCount: 1,
                        dateCreated: date.daySelected.toString(),
                        exerciseRPE: 10,
                      ),
                    );
                  },
                  child: Text("Add mock data"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
