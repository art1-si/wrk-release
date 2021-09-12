import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';

class PropertiesDropDown extends ConsumerWidget {
  const PropertiesDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final evmProvider = watch(entriesViewModel);

    return DropdownButton<GraphProperties>(
      onChanged: (GraphProperties? newValue) {}, //!: is this correct?
      items: GraphProperties.values.map((GraphProperties properties) {
        return DropdownMenuItem<GraphProperties>(
          value: properties,
          child: Text(
            properties.toString(),
          ),
        );
      }).toList(),
    );
  }
}
