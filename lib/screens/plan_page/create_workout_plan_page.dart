import 'package:flutter/material.dart';

import 'package:workout_notes_app/screens/plan_page/plan_page.dart';

class CreateWorkoutPlanPage extends StatefulWidget {
  final String exercisePlanName;
  final String exerciseName;
  final int orderIndex;

  const CreateWorkoutPlanPage({
    Key? key,
    required this.exercisePlanName,
    required this.exerciseName,
    required this.orderIndex,
  }) : super(key: key);
  @override
  _CreateWorkoutPlanPageState createState() => _CreateWorkoutPlanPageState();
}

class _CreateWorkoutPlanPageState extends State<CreateWorkoutPlanPage> {
  TextEditingController _setsTextController = TextEditingController();
  TextEditingController _minRepsTextController = TextEditingController();
  TextEditingController _maxRepsTextController = TextEditingController();
  TextEditingController _rpeTextController = TextEditingController();
  TextEditingController _notesTextController = TextEditingController();
  TextEditingController _weekdayforWorkoutTextController =
      TextEditingController();
  TextEditingController _restTimeTextController = TextEditingController();
  String dropDownWorkoutDay = "Upper";
  static const List<String> _workoutDays = [
    "Upper",
    "Lower",
    "Push",
    "Pull",
    "Legs",
    "Arms",
    "Chest",
    "Back",
    "Tricep",
    "Bicep",
    "Abs"
  ];
  _handleSubmit(
      String planName,
      String exerciseName,
      int minReps,
      int maxReps,
      int sets,
      int rpe,
      String notes,
      String workoutDay,
      double restTime,
      int orderId) async {}

  @override
  Widget build(BuildContext context) {
    print("CreatePlan build");
    //var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.exercisePlanName}"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Exercise",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${widget.exerciseName}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Sets",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _setsTextController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      Text(
                        "min Reps",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _minRepsTextController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      Text(
                        "max Reps",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _maxRepsTextController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "RPE",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _rpeTextController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      Text(
                        "Rest Time",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _restTimeTextController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Workout Day",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 100,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).accentColor,
                          ),
                          underline: Container(
                            height: 0,
                            color: Color(0xff667AFF),
                          ),
                          elevation: 0,
                          value: dropDownWorkoutDay,
                          style: Theme.of(context).textTheme.bodyText1,
                          dropdownColor: Theme.of(context).primaryColorLight,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownWorkoutDay = newValue!;
                            });
                          },
                          items: _workoutDays
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Notes",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _weekdayforWorkoutTextController,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).accentColor,
                      child: FlatButton(
                        onPressed: () {
                          _handleSubmit(
                            widget.exercisePlanName,
                            widget.exerciseName,
                            int.parse(_minRepsTextController.text),
                            int.parse(_maxRepsTextController.text),
                            int.parse(_setsTextController.text),
                            int.parse(_rpeTextController.text),
                            _notesTextController.text,
                            dropDownWorkoutDay,
                            double.parse(_restTimeTextController.text),
                            1,
                          );
                          _setsTextController.clear();
                          _minRepsTextController.clear();
                          _maxRepsTextController.clear();
                          _rpeTextController.clear();
                          _notesTextController.clear();
                          _weekdayforWorkoutTextController.clear();
                          _restTimeTextController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlanPage(
                                        planName: widget.exercisePlanName,
                                      )));
                        },
                        child: Text(
                          "SAVE",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: null,
                      child: Text("CANCEL"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
