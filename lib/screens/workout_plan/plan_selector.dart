import 'package:flutter/material.dart';

class PlanSelector extends StatelessWidget {
  const PlanSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Plans",
        ),
      ),
    );
  }
}
