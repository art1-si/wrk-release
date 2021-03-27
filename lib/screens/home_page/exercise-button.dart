import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';
import 'package:workout_notes_app/exercises_selector/type_selector_page.dart';
import 'package:workout_notes_app/plan_page/workout_plans_page.dart';

class ExerciseButton extends StatelessWidget {
  const ExerciseButton();

  @override
  Widget build(BuildContext context) {
    var showButton = Provider.of<ProviderOfQuickAddButton>(context);
    return Container(
      color: Colors.green,
      width: 50,
      height: 30,
      child: Stack(
        //alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment(-0.37, 0.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TypeSelectorPage()));
                showButton.setShowButton(false);
              },
              child: Container(
                height: 30,
                width: 110,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).cardColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "EXERCISES",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.37, 0.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkoutPlansPage()));
              },
              child: Container(
                height: 30,
                width: 110,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: Theme.of(context).cardColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "PLAN",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
