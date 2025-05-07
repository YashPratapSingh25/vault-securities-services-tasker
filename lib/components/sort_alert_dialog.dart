import 'package:flutter/material.dart';

class SortAlertDialog extends StatefulWidget {
  String selectedSort;
  List<String> sortFilters;
  Function(String selectedSort) onSelect;
  SortAlertDialog({super.key, required this.selectedSort, required this.sortFilters, required this.onSelect});

  @override
  State<SortAlertDialog> createState() => _SortAlertDialogState();
}

class _SortAlertDialogState extends State<SortAlertDialog> {

  @override
  Widget build(BuildContext context) {
    List<String> sortFilters = widget.sortFilters ?? [];
    return AlertDialog(
      title: const Text("Sort By"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sortFilters.length,
          itemBuilder: (context, index) {
            if(sortFilters.isEmpty){
              return const Center(child: Text("Error occurred"),);
            }
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(sortFilters[index]),
              leading: Radio(
                value: sortFilters[index],
                groupValue: widget.selectedSort,
                onChanged: (value) {
                  setState(() {
                    widget.selectedSort = value!;
                  });
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onSelect(widget.selectedSort);
            Navigator.pop(context);
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}