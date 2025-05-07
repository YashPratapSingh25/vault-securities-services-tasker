import 'package:flutter/material.dart';

class PriorityDropdown extends StatefulWidget {
  final String? selectedPriority;
  final Function(String newPriority)? onSelect;

  const PriorityDropdown({super.key, this.selectedPriority, this.onSelect});

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).hintColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        isExpanded: true, // ✅ Makes the dropdown take full width
        underline: Container(),
        alignment: AlignmentDirectional.centerStart,
        hint: Text(
          "Select Priority",
          style: TextStyle(
            fontSize: 15.6,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        value: widget.selectedPriority,
        onChanged: (String? newValue) {
          widget.onSelect?.call(newValue!);
        },
        items: <String>['High', 'Medium', 'Low']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
