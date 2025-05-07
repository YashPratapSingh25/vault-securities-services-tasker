import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:tasker/pages/add_edit_task_page.dart';
import 'package:tasker/services/firestore_service/task_firestore_service.dart';
import '../models/task.dart';

class TaskContainer extends StatefulWidget {

  final DocumentSnapshot task;

  const TaskContainer({
    super.key, required this.task,
  });

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {

  final TaskFirestoreService _taskFirestoreService = TaskFirestoreService.instance;

  String _monthInText(int monthNum){
    switch(monthNum){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sept";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "Error";
  }


  late DateTime dueDateTimestamp;
  late int monthInInt;
  late int day;
  late int year;

  List tags = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> taskMap = widget.task.data() as Map<String, dynamic>;
    final String docId = widget.task.id;

    final task = widget.task;
    dueDateTimestamp = taskMap['dueDate'].toDate();
    monthInInt = dueDateTimestamp.month;
    day = dueDateTimestamp.day;
    year = dueDateTimestamp.year;
    tags = taskMap['tags'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditTaskPage(docId: docId,taskMap: taskMap,),));
                },
                icon: Icons.edit,
                backgroundColor: Colors.green,
              ),
              SlidableAction(
                onPressed: (context){
                  _taskFirestoreService.deleteTask(docId);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
              )
            ]
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.deepPurple[200],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskMap['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: taskMap['isCompleted'] == true
                              ? Colors.grey
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          decoration: taskMap['isCompleted'] == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Text(
                        "Due Date: $day ${_monthInText(monthInInt)}, $year",
                        style: TextStyle(
                          color: taskMap['isCompleted'] == true
                              ? Colors.grey
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Priority: ${taskMap['priority']}",
                        style: TextStyle(
                          color: taskMap['isCompleted'] == true
                              ? Colors.grey
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Tags: ${tags.join(", ")}",
                        style: TextStyle(
                          color: taskMap['isCompleted'] == true
                              ? Colors.grey
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Checkbox(
                value: taskMap['isCompleted'],
                onChanged: (newValue) {
                  setState(() {
                    taskMap['updatedAt'] = DateTime.now();
                    taskMap['isCompleted'] = newValue!;
                    _taskFirestoreService.updateTask(docId, taskMap);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
