import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/task.dart';

class TaskFirestoreService{

  static final instance = TaskFirestoreService._constructor();
  TaskFirestoreService._constructor();

  final CollectionReference _tasks = FirebaseFirestore.instance.collection("tasks");

  Map <String, dynamic> _toMap(Task task){
    return {
      "userId": task.userId,
      "title": task.title,
      "description": task.description,
      "createdAt": Timestamp.fromDate(task.createdAt),
      "dueDate": Timestamp.fromDate(task.dueDate),
      "updatedAt": Timestamp.fromDate(task.updatedAt),
      "isCompleted": task.isCompleted,
      "tags": task.tags,
      "priority": task.priority
    };
  }

  Task _fromMap(Map<String, dynamic> map) {
    Task task = Task()
    ..userId= map["userId"]
    ..title= map["title"]
    ..description= map["description"]
    ..createdAt= map["createdAt"].toDate()
    ..dueDate= map["dueDate"].toDate()
    ..updatedAt=map["updatedAt"].toDate()
    ..isCompleted= map["isCompleted"]
    ..tags= map["tags"]
    ..priority= map["priority"];
    return task;
  }

  Future<void> addTask(Task task) async {
    await _tasks.add(_toMap(task));
  }

  Stream<QuerySnapshot<Object?>> getTasks() {
    return _tasks
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  }

  Future <void> updateTask(String? docID, Map<String, dynamic> task) async {
    await _tasks.doc(docID).update(task);
  }

  Future <void> deleteTask(String? docId) async {
    await _tasks.doc(docId).delete();
  }

  Future <Task?> getTask(String docId) async {
    var task = await _tasks.doc(docId).get();
    return _fromMap(task.data() as Map<String, dynamic>);
  }

}