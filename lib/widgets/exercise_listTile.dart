import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/plans_stream.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';
import 'package:workout_notes_app/screens/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/create_workout_plan_page.dart';

class ExerciseListTile extends StatelessWidget {
  final String exerciseName;
  final int index;
  final List<ExerciseModel> typeSnapshot;
  final WorkoutPlanStreams planStream;

  ExerciseListTile(
      {Key key,
      this.exerciseName,
      this.index,
      this.typeSnapshot,
      this.planStream})
      : super(key: key);

  final TextEditingController _workoutNameTextController =
      TextEditingController();
  _selectPlanDialog(context, String selectedExerciseName) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Workout Plans"),
            content: StreamBuilder<List<ExercisePlanModel>>(
                stream: planStream.exercisePlanStream,
                builder:
                    (context, AsyncSnapshot<List<ExercisePlanModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("no data"));
                  }
                  List namesList = [];
                  for (var planName in snapshot.data) {
                    namesList.add(planName.planName);
                  }
                  var eachProgramName = namesList.toSet();

                  return ListView.builder(
                      itemCount: eachProgramName.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text("${eachProgramName.elementAt(index)}"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateWorkoutPlanPage(
                                    exercisePlanName: namesList[index],
                                    exerciseName: selectedExerciseName,
                                  ),
                                ));
                          },
                        );
                      });
                }),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL"),
              ),
            ],
          );
        });
  }

  _createNewPlanDialog(context, String selectedExerciseName) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Plan Name"),
            content: TextField(
              controller: _workoutNameTextController,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateWorkoutPlanPage(
                          exercisePlanName: _workoutNameTextController.text,
                          exerciseName: selectedExerciseName,
                        ),
                      ));
                },
                child: Text("SAVE"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL"),
              ),
            ],
          );
        });
  }

  void _addToWorkoutPlans(context, String selectedExerciseName) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: Text('Create New Plan'),
                    onTap: () =>
                        {_createNewPlanDialog(context, selectedExerciseName)}),
                ListTile(
                    leading: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    title: Text('Select Plan'),
                    onTap: () =>
                        {_selectPlanDialog(context, selectedExerciseName)}),
              ],
            ),
          );
        });
  }

  void _settingModalBottomSheet(context, String selectedExerciseName) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: new Text('Add to Plan'),
                    onTap: () => {
                          _addToWorkoutPlans(context, selectedExerciseName),
                        }),
                ListTile(
                  leading: new Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  title: new Text('Edit'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: new Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  title: new Text('Delete'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  _showButtonIfTrue(context, bool show, String planName, String exerciseName) {
    if (show) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateWorkoutPlanPage(
                  exercisePlanName: planName,
                  exerciseName: exerciseName,
                ),
              ));
        },
        child: Text('Quick Add'),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var showButton = Provider.of<ProviderOfQuickAddButton>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddExerciseToLog(
                              selectedIndex: index,
                              showPlanDetails: false,
                              selectedExercise: typeSnapshot)));
                },
                child: Container(
                  width: (showButton.getshowButton()) ? null : 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Text(exerciseName,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
              ),
              (showButton.getshowButton())
                  ? _showButtonIfTrue(
                      context,
                      showButton.getshowButton(),
                      showButton.getAddQuickPlanName(),
                      typeSnapshot[index].exerciseName,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => _settingModalBottomSheet(
                            context, typeSnapshot[index].exerciseName),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    )
            ],
          ),
          const Divider(
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}
