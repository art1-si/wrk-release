import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/database/asset_db_of_exercises.dart';
import 'package:workout_notes_app/database/exercise_db.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/provider/exercise_log_stream.dart';
import 'package:workout_notes_app/provider/log_values_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/reps_value_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/text_field_number_picker.dart';

class LogScreen extends StatelessWidget {
  final ExerciseModel selectedExercise;
  final bool showPlanDetails;
  final ExercisePlanModel planDetails;
  final int selectedIndex;
  final double weightValue;
  final int repsValue;
  final int rpeValue;
  LogScreen(
      {Key key,
      this.selectedExercise,
      this.showPlanDetails,
      this.planDetails,
      this.selectedIndex,
      this.weightValue,
      this.repsValue,
      this.rpeValue})
      : super(key: key);

  final ExerciseLogStreams exerciseLogStream = ExerciseLogStreams();
  final ExerciseLogDatabase logDb = ExerciseLogDatabase();
  final ExerciseListDb db = ExerciseListDb();

  final String notes = "";

  //final int exerciseIndex;

  _updateToNewLast(String name, String type, double lastWeight, int lastreps,
      int lastRPE, id) {
    var exerciseModelUpdate =
        ExerciseModel(id, name, type, lastWeight, lastreps, lastRPE);
    db.updateExercise(exerciseModelUpdate, id);
  }

  //void _onItemTapped(int index) {
  //  rpeValue = index;
  //}

  _handleSubmit(context, weight, reps, rpe) async {
    var b = Provider.of<DaySelectorModel>(context, listen: false);
    ExerciseLogModel newExerciseLog = ExerciseLogModel(
      selectedExercise.exerciseName,
      selectedExercise.exerciseType,
      weight,
      reps,
      "${b.daySelected.year}-${DateFormat('MM').format(b.daySelected)}-${DateFormat('dd').format(b.daySelected)}",
      rpe,
      notes,
    );
    await logDb.saveExercise(newExerciseLog);
  }

  _showPlanDetail(BuildContext context, int sets, int minReps, int maxReps,
      int rpe, double restTime) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "SETS: $sets",
            style: Theme.of(context).textTheme.overline,
          ),
          Text(
            "REPS: $minReps - $maxReps",
            style: Theme.of(context).textTheme.overline,
          ),
          Text(
            "RPE: $rpe",
            style: Theme.of(context).textTheme.overline,
          ),
          Text(
            "REST TIME: $restTime",
            style: Theme.of(context).textTheme.overline,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var b = Provider.of<DaySelectorModel>(context, listen: false);
    var logValuesProvider =
        Provider.of<LogValuesProvider>(context, listen: false);
    logValuesProvider.weightSetter(selectedExercise.lastWeight);
    print(selectedExercise.lastWeight);
    logValuesProvider.repsSetter(selectedExercise.lastReps);
    print(selectedExercise.lastReps);
    logValuesProvider.rpeSetter(selectedExercise.lastRPE);
    print(selectedExercise.lastRPE);
    return ListView(
      children: <Widget>[
        (showPlanDetails)
            ? _showPlanDetail(
                context,
                planDetails.sets,
                planDetails.minRepsPerSet,
                planDetails.maxRepsPerSet,
                planDetails.rpe,
                planDetails.restTime)
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(// Submitt picker
              children: <Widget>[
            Container(
              //width: screenWidth / 2,
              child: WeightNumberPicker(
                title: "WEIGHT",
                numberChangeValue: 2.5,
                numberValue: logValuesProvider.weightValue,
                onTapLeftButton: () {
                  if (logValuesProvider.weightValue > 0) {
                    logValuesProvider
                        .setWeightTo(logValuesProvider.weightValue - 2.5);
                  }
                },
                onTapRightButton: () {
                  logValuesProvider
                      .setWeightTo(logValuesProvider.weightValue + 2.5);
                },
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              //indent: screenWidth / 3,
              //endIndent: screenWidth / 3,
            ),
            Container(
              //width: screenWidth / 3,
              child: RepsNumberPicker(
                title: "REPS",
                numberChangeValue: 1,
                numberValue: logValuesProvider.repsValue,
                onTapLeftButton: () {
                  if (logValuesProvider.repsValue > 0) {
                    logValuesProvider
                        .setRepsTo(logValuesProvider.repsValue - 1);
                  }
                },
                onTapRightButton: () {
                  logValuesProvider.setRepsTo(logValuesProvider.repsValue + 1);
                },
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              //indent: screenWidth / 3,
              //endIndent: screenWidth / 3,
            ),
            Divider(
              thickness: 1,
              height: 0,
              indent: screenWidth / 3,
              endIndent: screenWidth / 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
              child: InkWell(
                onTap: () {
                  _handleSubmit(context, logValuesProvider.weightValue,
                      logValuesProvider.repsValue, logValuesProvider.rpeValue);
                  _updateToNewLast(
                    selectedExercise.exerciseName,
                    selectedExercise.exerciseType,
                    logValuesProvider.weightValue,
                    logValuesProvider.repsValue,
                    logValuesProvider.rpeValue,
                    selectedExercise.id,
                  );
                  exerciseLogStream.addExercieLogToStream();
                },
                child: Container(
                  height: 30,
                  width: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Text(
                    "SAVE",
                    style: Theme.of(context).textTheme.button,
                  )),
                ),
              ),
            )
          ]),
        ),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: StreamBuilder<List<ExerciseLogModel>>(
            stream: exerciseLogStream.getLogToDate(
                "${b.daySelected.year}-${DateFormat('MM').format(b.daySelected)}-${DateFormat('dd').format(b.daySelected)}"),
            builder: (BuildContext context,
                AsyncSnapshot<List<ExerciseLogModel>> snapshot) {
              if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Container();
              }
              var filteredSnapshot = snapshot.data
                  .where((element) =>
                      element.exerciseName == selectedExercise.exerciseName)
                  .toList();
              return Container(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredSnapshot.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onLongPress: () {
                        exerciseLogStream
                            .deleteSelectedLog(filteredSnapshot[index].id);
                      },
                      child: _LogItem(
                        setField: "Set ${index + 1}",
                        weightField: "${filteredSnapshot[index].weight}",
                        repsField: "${filteredSnapshot[index].reps}",
                        rpeField: "${filteredSnapshot[index].exerciseRPE}",
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LogItem extends StatelessWidget {
  final String setField;
  final String weightField;
  final String repsField;
  final String rpeField;

  const _LogItem(
      {Key key, this.setField, this.weightField, this.repsField, this.rpeField})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(setField),
                Row(
                  children: <Widget>[
                    Text("Weight "),
                    Text(weightField),
                  ],
                ),
                Row(
                  children: <Widget>[Text("Reps "), Text(repsField)],
                ),
                Row(
                  children: <Widget>[Text("RPE "), Text(rpeField)],
                ),
              ]),
        ),
        Divider(),
      ],
    );
  }
}
