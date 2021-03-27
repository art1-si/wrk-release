import 'package:flutter/material.dart';
import 'package:workout_notes_app/services/1rm_formula.dart';
import 'package:workout_notes_app/services/logics.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';

class RepMaxView extends StatelessWidget {
  final List<ExerciseLogModel> exerciseLog;

  final List<int> oneRMProcents = [
    110,
    100,
    90,
    80,
    70,
    60,
    50,
    40,
    30,
    20,
    10,
    5,
    1
  ];
  RepMaxView({Key key, this.exerciseLog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(" repmax page build ");
    if (exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    var lastElementFromSnapshot = exerciseLog.last;
    var oneRepMax = epleyCalOneRepMax(
        lastElementFromSnapshot.weight, lastElementFromSnapshot.reps);
    return Center(
      child: ListView.builder(
        itemCount: oneRMProcents.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "${oneRMProcents[index]}%",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "of 1RM",
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "${roundDoubleToInt(oneRepMax * (oneRMProcents[index] / 100))}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
