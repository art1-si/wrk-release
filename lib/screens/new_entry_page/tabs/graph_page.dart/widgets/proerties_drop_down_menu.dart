import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/chart_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_selector_provider.dart';

class PropertiesDropDown extends ConsumerWidget {
  const PropertiesDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _selector = watch(graphSelector);

    return DropdownButton<GraphProperties>(
      value: _selector.graphProperties,
      onChanged: (GraphProperties? newValue) {
        context.read(graphSelector).setGraphProperties(newValue!);
      }, //!: is this correct?
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
