import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasker/components/task_container.dart';

import '../models/task.dart';

class TaskList extends StatefulWidget {

  List<DocumentSnapshot>? tasks;

  TaskList({super.key, this.tasks});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.tasks?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskContainer(task: widget.tasks![index],);
      },
    );
  }
}
