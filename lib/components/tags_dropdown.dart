import 'package:flutter/material.dart';
import 'package:tasker/models/tag.dart';
import 'package:tasker/pages/manage_tags.dart';

class TagsDropdown extends StatefulWidget {

  final List<String>? items;
  final List selectedTags;
  final void Function(List<dynamic> selectedItems)? onConfirm;

  const TagsDropdown({super.key, required this.items, this.onConfirm, required this.selectedTags});

  @override
  State<TagsDropdown> createState() => _TagsDropdownState();
}

class _TagsDropdownState extends State<TagsDropdown> {


  @override
  void initState() {
    // if(widget.selectedTags.isNotEmpty){
    //   selectedTags = widget.selectedTags;
    //   // TODO HELLO FIX THIS PLEASE
    //   for(var tag in selectedTags){
    //     selectedTagsString.add(_tagDbService.getTag(tag)!.name);
    //   }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List selectedTags = widget.selectedTags;
    return GestureDetector(
      onTap: (){
        showDialog(
          context: context,
          builder: (context) {
            final tags = widget.items;
            return StatefulBuilder(
              builder: (context, setDialogState) {
                return AlertDialog(
                  title: Text("Choose Tags"),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: tags!.isEmpty ?
                    Center(
                      child: Row(
                        children: [
                          const Text("No tags available."),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ManageTags(),));
                            },
                            child: const Text("Go to Manage Tags")
                          )
                        ]
                      )
                    ):
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: tags.length,
                      itemBuilder: (context, index) {
                        final tag = tags[index];
                        return CheckboxListTile(
                          title: Text(tag),
                          value: selectedTags.contains(tag),
                          onChanged: (newValue){
                            setDialogState((){
                              if(newValue == true){
                                selectedTags.add(tag);
                              }else{
                                selectedTags.remove(tag);
                              }
                            });
                          },
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
                        widget.onConfirm!(selectedTags);
                        Navigator.pop(context);
                      },
                      child: const Text("Confirm"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.selectedTags.isEmpty ? "Choose Tags" : selectedTags.join(", "),
          style: const TextStyle(
            fontSize: 15.6
          ),
        )
      ),
    );
  }
}