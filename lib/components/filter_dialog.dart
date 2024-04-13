import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

enum FilterType {
  time,
  alphabet,
}

enum OrderType { ascending, descending }

class _FilterDialogState extends State<FilterDialog> {
  FilterType type = FilterType.time;
  OrderType order = OrderType.ascending;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.center,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SegmentedButton<FilterType>(
                  segments: const [
                    ButtonSegment<FilterType>(
                      value: FilterType.time,
                      label: Text('Time'),
                    ),
                    ButtonSegment<FilterType>(
                      value: FilterType.alphabet,
                      label: Text('Alphabet'),
                    ),
                  ],
                  selected: <FilterType>{type},
                  onSelectionChanged: (Set<FilterType> newSelection) {
                    setState(() {
                      type = newSelection.first;
                    });
                  },
                ),
                SegmentedButton(
                  segments: const [
                    ButtonSegment<OrderType>(
                        value: OrderType.ascending, label: Text('Ascending')),
                    ButtonSegment<OrderType>(
                        value: OrderType.descending, label: Text('Descending'))
                  ],
                  selected: <OrderType>{order},
                  onSelectionChanged: (Set<OrderType> newSelection) {
                    setState(() {
                      order = newSelection.first;
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Apply"))
                  ]),
                )
              ],
            )));
  }
}
