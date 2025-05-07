import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasker/providers/tag_provider.dart';
import 'package:tasker/providers/task_provider.dart';
import 'package:tasker/services/auth_service/auth_state_helper.dart';
import 'package:tasker/services/themes.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskProvider(),),
          ChangeNotifierProvider(create: (context) => TagProvider(),),
        ],
        child: const TaskerApp(),
      )
  );
}


class TaskerApp extends StatefulWidget {
  const TaskerApp({super.key});

  @override
  State<TaskerApp> createState() => _TaskerAppState();
}

class _TaskerAppState extends State<TaskerApp> {


  @override
  void didChangeDependencies() {
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthStateHelper(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
