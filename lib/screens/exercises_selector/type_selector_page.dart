import 'package:flutter/material.dart';

class TypeSelectorPage extends StatelessWidget {
  const TypeSelectorPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Exercises",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
