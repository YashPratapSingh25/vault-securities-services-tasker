import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/services/firestore_service/task_firestore_service.dart';

class TaskProvider with ChangeNotifier{
  final TaskFirestoreService _taskFirestoreService = TaskFirestoreService.instance;

  Stream<QuerySnapshot>? _taskStream;
  Stream<QuerySnapshot>? get taskStream => _taskStream;

  void fetchTasks() {
    _taskStream = _taskFirestoreService.getTasks();
  }
}