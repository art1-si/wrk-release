import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/workout_plan.dart';

class MyClosedContainer extends StatelessWidget {
  final WorkoutPlan workout;

  const MyClosedContainer({Key? key, required this.workout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        )
            //color: Theme.of(context).primaryColor,
            ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 30,
              child: Center(
                child: Text(
                  "${workout.exerciseName}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColorDark,
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "SETS: ${workout.sets}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Text(
                    "REPS: ${workout.minRepsPerSet} - ${workout.maxRepsPerSet}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Text(
                    "RPE: ${workout.rpe}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Text(
                    "REST TIME: ${workout.restTime}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
