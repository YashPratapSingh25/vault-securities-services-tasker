import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:tasker/components/auth_text_field.dart';
import 'package:tasker/components/datetime_picker.dart';
import 'package:tasker/components/priority_dropdown.dart';
import 'package:tasker/components/tags_dropdown.dart';
import 'package:tasker/models/task.dart';import 'package:tasker/services/firestore_service/task_firestore_service.dart';
import '../models/tag.dart';
import '../providers/tag_provider.dart';

class AddEditTaskPage extends StatefulWidget {

  String? docId;
  Map<String, dynamic>? taskMap;

  AddEditTaskPage({super.key, this.docId, this.taskMap});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {

  final TaskFirestoreService _taskFirestoreService = TaskFirestoreService.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int? day, month, year;
  DateTime? datetime;

  List <String>? tags;
  List selectedTags = [];
  String? selectedPriority;

  @override
  void initState() {
    Map<String, dynamic>? taskMap = widget.taskMap;
    if(taskMap != null){

      titleController.text = taskMap['title'];
      descriptionController.text = taskMap['description'];
      selectedTags = taskMap['tags'];
      selectedPriority = taskMap['priority'];
      datetime = (taskMap['dueDate']).toDate();
      day = datetime?.day;
      month = datetime?.month;
      year = datetime?.year;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TagProvider tagProvider = Provider.of<TagProvider>(context, listen: false);
    tags = tagProvider.tagsList;
    Map<String, dynamic>? taskMap = widget.taskMap;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          taskMap == null ? "Add Task" : "Edit Task",
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                hintText: "Enter task title",
                controller: titleController
              ),
              const SizedBox(height: 20,),
              AuthTextField(
                hintText: "Enter task description (Optional)",
                controller: descriptionController
              ),
              const SizedBox(height: 20,),
              DatetimePicker(
                onSelect: (date){
                  setState(() {
                    datetime = date;
                    day = date?.day;
                    month = date?.month;
                    year = date?.year;
                  });
                },
                datetime: datetime,
              ),
              const SizedBox(height: 20,),
              TagsDropdown(
                items: tags,
                selectedTags: selectedTags,
                onConfirm: (newValues){
                  setState(() {
                    selectedTags = newValues;
                  });
                },
              ),
              const SizedBox(height: 20,),
              PriorityDropdown(
                selectedPriority: selectedPriority,
                onSelect: (newPriority){
                  setState(() {
                    selectedPriority = newPriority;
                  });
                },
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(
                        titleController.text.isEmpty ||
                        datetime == null ||
                        selectedTags.isEmpty ||
                        selectedPriority == null
                      ){
                        const snackBar = SnackBar(content: Text("Please fill all the fields"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        try{
                          if(widget.taskMap == null){
                            Task newTask = Task()
                              ..userId= FirebaseAuth.instance.currentUser!.uid
                              ..title= titleController.text
                              ..description= descriptionController.text
                              ..createdAt= DateTime.now()
                              ..dueDate= datetime!
                              ..updatedAt= DateTime.now()
                              ..isCompleted= false
                              ..tags= selectedTags
                              ..priority= selectedPriority!;
                            _taskFirestoreService.addTask(newTask);
                            const snackBar = SnackBar(content: Text("Task Added"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }else{
                            taskMap?['userId']= FirebaseAuth.instance.currentUser!.uid;
                            taskMap?['title']= titleController.text;
                            taskMap?['description']= descriptionController.text;
                            taskMap?['dueDate']= datetime!;
                            taskMap?['updatedAt']= DateTime.now();
                            taskMap?['tags']= selectedTags;
                            taskMap?['priority']= selectedPriority!;
                            _taskFirestoreService.updateTask(widget.docId, taskMap!);
                            const snackBar = SnackBar(content: Text("Task Updated"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          Navigator.pop(context);
                        }on Exception catch (e) {
                          const snackBar = SnackBar(content: Text("Error occurred"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      taskMap == null ? "Add" : "Edit",
                      style: const TextStyle(
                        fontSize: 18
                      ),
                    )
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    )
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
