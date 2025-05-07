import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/providers/tag_provider.dart';
import 'package:tasker/services/firestore_service/tag_firestore_service.dart';
import '../models/tag.dart';

class AddEditTags extends StatefulWidget {
  String? docId;
  Map<String, dynamic>? tag;
  AddEditTags({super.key, this.docId, this.tag});

  @override
  State<AddEditTags> createState() => _AddEditTagsState();
}

class _AddEditTagsState extends State<AddEditTags> {

  final TextEditingController _tagController = TextEditingController();
  final TagFirestoreService _tagFirestoreService = TagFirestoreService.instance;

  @override
  void initState() {
    if(widget.tag != null){
      _tagController.text = widget.tag?['name'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TagProvider tagProvider = Provider.of<TagProvider>(context);
    return AlertDialog(
      title: widget.tag == null ? const Text("Add tag") : const Text("Edit tag"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if(widget.tag == null){
              Tag tag = Tag()
                ..userId = FirebaseAuth.instance.currentUser!.uid
                ..name = _tagController.text
                ..updatedAt = DateTime.now();
              _tagFirestoreService.addTag(tag);
              tagProvider.updateTagsList();
            }else{
              widget.tag?['name'] = _tagController.text;
              widget.tag?['updatedAt'] = DateTime.now();
              _tagFirestoreService.updateTag(widget.docId, widget.tag!);
              tagProvider.updateTagsList();
            }
            _tagController.clear();
            Navigator.pop(context);
          },
          child: widget.tag == null ? const Text("Add") : const Text("Edit"),
        ),
        ElevatedButton(
            onPressed: (){
              _tagController.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancel")
        )
      ],
      content: TextField(
        controller: _tagController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: "Enter tag",
        ),
      ),
    );
  }
}
