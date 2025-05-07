import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/services/firestore_service/tag_firestore_service.dart';

class TagProvider with ChangeNotifier{
  final TagFirestoreService _tagFirestoreService = TagFirestoreService.instance;

  Stream<QuerySnapshot>? _tagStream;
  Stream<QuerySnapshot>? get tagStream => _tagStream;

  List<String>? _tagsList;
  List<String>? get tagsList => _tagsList;

  void fetchTags() {
    _tagStream = _tagFirestoreService.getTags();
  }

  void updateTagsList() async {
    _tagsList = await _tagFirestoreService.getTagsList();
  }
}