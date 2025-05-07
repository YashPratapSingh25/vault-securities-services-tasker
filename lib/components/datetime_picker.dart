import 'package:flutter/material.dart';

class DatetimePicker extends StatefulWidget {
  void Function(DateTime? date)? onSelect;
  DateTime? datetime;
  DatetimePicker({super.key, this.onSelect, this.datetime});

  @override
  State<DatetimePicker> createState() => _DatetimePickerState();
}

class _DatetimePickerState extends State<DatetimePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var selectedDate = await showDatePicker(
          context: context,
          initialDate: widget.datetime ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100)
        );

        if(selectedDate != null){
          if(selectedDate.isBefore(DateTime.now())){
            const snackBar = SnackBar(content: Text("Due date cannot be before than current date"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
          widget.onSelect!(selectedDate);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.datetime != null ? "${widget.datetime?.day}/${widget.datetime?.month}/${widget.datetime?.year}" : "Select due date",
              style: const TextStyle(
                  fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
