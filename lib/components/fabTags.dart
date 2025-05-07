import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/components/add_edit_tags.dart';
import 'package:tasker/models/tag.dart';

class FabTags extends StatefulWidget {
  Tag? tag;
  FabTags({super.key, this.tag});

  @override
  State<FabTags> createState() => _FabTagsState();
}

class _FabTagsState extends State<FabTags> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (context) {
            return AddEditTags();
          },
        );
      },
      backgroundColor: Colors.deepPurple[200],
      child: const Icon(Icons.add),
    );
  }
}
