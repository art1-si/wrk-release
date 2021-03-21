import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/plans_stream.dart';
import 'package:workout_notes_app/screens/plan_page.dart';
import 'package:workout_notes_app/widgets/workout_listTile.dart';

class WorkoutPlansPage extends StatelessWidget {
  final WorkoutPlanStreams planStream = WorkoutPlanStreams();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Plans"),
      ),
      body: StreamBuilder<List<ExercisePlanModel>>(
        stream: planStream.planNamesStream,
        builder: (context, AsyncSnapshot<List<ExercisePlanModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text("no data"));
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              return WorkoutListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanPage(
                                planName: "${snapshot.data[index].planName}",
                              )));
                },
                title: Text(
                  "${snapshot.data[index].planName}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
