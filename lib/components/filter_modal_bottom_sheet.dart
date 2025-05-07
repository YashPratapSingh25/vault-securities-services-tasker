import 'package:flutter/material.dart';
import 'package:tasker/components/priority_dropdown.dart';
import 'package:tasker/components/tags_dropdown.dart';
import 'datetime_picker.dart';

class FilterModalBottomSheet extends StatefulWidget {
  final Function(bool isFilterApplied, bool? filterCompleted, DateTime? filterDateTime, String? filterPriority, List? filterTags)? onApply;
  final bool? isFilterApplied;
  final bool? filterCompletedStatus;
  final DateTime? filterDateTime;
  final String? filterPriority;
  final List? filterTags;
  const FilterModalBottomSheet({super.key, this.onApply, this.isFilterApplied, this.filterDateTime, this.filterPriority, this.filterTags, this.filterCompletedStatus});

  @override
  State<FilterModalBottomSheet> createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {


  DateTime? datetime;
  int? day;
  int? month;
  int? year;

  String? selectedPriority;

  bool? selectedCompleteStatus;

  List selectedTags = [];

  @override
  void initState() {
    selectedCompleteStatus = widget.filterCompletedStatus;
    datetime = widget.filterDateTime;
    selectedPriority = widget.filterPriority;
    selectedTags = widget.filterTags ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: Column(
            children: [
              StatefulBuilder(
                builder: (context, setCompleteStatus) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status"),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).hintColor),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: 300,
                        child: DropdownButton(
                          icon: Icon(null),
                          underline: Container(),
                          value: selectedCompleteStatus,
                          hint: Text(
                            "Choose Completion Status",
                            style: TextStyle(
                                fontSize: 15.6,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).textTheme.bodySmall!.color
                            ),
                          ),
                          items: ["Complete", "Incomplete"].map(
                            (element){
                              return DropdownMenuItem(
                                value: element == "Complete",
                                child: Text(element)
                              );
                            }
                          ).toList(),
                          onChanged: (newValue){
                            setCompleteStatus(() {
                              selectedCompleteStatus = newValue;
                            });
                          }
                        ),
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 25,),

              StatefulBuilder(
                builder: (context, setDateState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Due Date"),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      SizedBox(
                        width: 300,
                        child: DatetimePicker(
                          onSelect: (date){
                            setDateState(() {
                              datetime = date;
                            });
                          },
                          datetime: datetime,
                        ),
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 25,),

              StatefulBuilder(
                builder: (context, setPriorityState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Priority"),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      SizedBox(
                        width: 300,
                        child: PriorityDropdown(
                          selectedPriority: selectedPriority,
                          onSelect: (newPriority){
                            setPriorityState(() {
                              selectedPriority = newPriority;
                            });
                          },
                        ),
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 25,),

              StatefulBuilder(
                builder: (context, setTagsState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tags"),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      SizedBox(
                        width: 300,
                        child: TagsDropdown(
                          items: [],
                          selectedTags: selectedTags,
                          onConfirm: (newValues){
                            setTagsState(() {
                              selectedTags = newValues;
                            });
                          },
                        ),
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if(
                        selectedCompleteStatus != null ||
                        datetime != null ||
                        selectedPriority != null ||
                        selectedTags.isNotEmpty
                      ){
                        widget.onApply!(
                            true,
                            selectedCompleteStatus,
                            datetime,
                            selectedPriority,
                            selectedTags
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Apply Filters")
                  ),
                  ElevatedButton(
                      onPressed: () {
                        selectedCompleteStatus = null;
                        datetime = null;
                        selectedPriority = null;
                        selectedTags = [];
                        widget.onApply!(
                            false,
                            selectedCompleteStatus,
                            datetime,
                            selectedPriority,
                            selectedTags
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Clear Filters")
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
