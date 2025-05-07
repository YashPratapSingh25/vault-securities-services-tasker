import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/components/drawer_component.dart';
import 'package:tasker/components/tasks_list.dart';
import 'package:tasker/models/task.dart';
import 'package:tasker/pages/add_edit_task_page.dart';
import 'package:tasker/providers/task_provider.dart';

import '../providers/tag_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool filterTagsInTaskTags(List taskTags, List filterTags){
    for(var filterTag in filterTags){
      if(!taskTags.contains(filterTag)){
        return false;
      }
    }
    return true;
  }
  
  int priorityHelper(String priority){
    switch(priority){
      case "Low":
        return 0;
      case "Medium":
        return 1;
      case "High":
        return 2;
    }
    return -1;
  }


  @override
  void initState() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final tagProvider = Provider.of<TagProvider>(context, listen: false);
    if(FirebaseAuth.instance.currentUser != null && taskProvider.taskStream == null){
      taskProvider.fetchTasks();
    }
    if(FirebaseAuth.instance.currentUser != null && tagProvider.tagStream == null){
      tagProvider.fetchTags();
    }
    if(FirebaseAuth.instance.currentUser != null && tagProvider.tagsList == null){
      tagProvider.updateTagsList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tasker",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth
                  .instance
                  .signOut();
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello,",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: const Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: taskProvider.taskStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error occurred when fetching tasks"),
                      );
                    }
                    List<DocumentSnapshot>? tasksList = snapshot.data?.docs;
                    return TaskList(
                      tasks: tasksList
                    );
                  },
                );
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditTaskPage(),));
        },
        backgroundColor: Colors.deepPurple[200],
        child: const Icon(
          Icons.add,
        ),
      ),
      drawer: DrawerComponent(context: context,),
    );
  }
}
