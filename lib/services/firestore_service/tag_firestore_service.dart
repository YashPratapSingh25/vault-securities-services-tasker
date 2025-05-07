import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/tag.dart';

class TagFirestoreService{

  static final instance = TagFirestoreService._constructor();
  TagFirestoreService._constructor();

  Map <String, dynamic> _toMap(Tag tag){
    return {
      "userId": tag.userId,
      "name": tag.name,
      "updatedAt" : Timestamp.fromDate(tag.updatedAt)
    };
  }

  final CollectionReference _tags = FirebaseFirestore.instance.collection("tags");

  Future <void> addTag(Tag tag) async {
    await _tags.add(_toMap(tag));
  }

  Stream<QuerySnapshot<Object?>> getTags() {
    return _tags
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  }

  Future<List<String>> getTagsList() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('tags').get();

    return querySnapshot.docs
      .map((doc) => doc.data()["name"] as String)
      .toList();
  }

  Future <void> updateTag(String? docID, Map<String, dynamic> tag) async {
    await _tags.doc(docID).update(tag);
  }

  Future <void> deleteTag(String? docId) async {
    await _tags.doc(docId).delete();
  }
}