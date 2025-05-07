import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/components/add_edit_tags.dart';
import 'package:tasker/components/fabTags.dart';
import 'package:tasker/providers/tag_provider.dart';
import 'package:tasker/services/firestore_service/tag_firestore_service.dart';

class ManageTags extends StatefulWidget {
  const ManageTags({super.key});

  @override
  State<ManageTags> createState() => _ManageTagsState();
}

class _ManageTagsState extends State<ManageTags> {
  final TagFirestoreService _tagFirestoreService = TagFirestoreService.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Tags",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Consumer<TagProvider>(
        builder: (context, tagProvider, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: tagProvider.tagStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error occurred when fetching tags"),
                );
              }
              List<DocumentSnapshot>? tagsList = snapshot.data?.docs;
              return ListView.builder(
                itemCount: tagsList?.length,
                itemBuilder: (context, index) {
                  String? docId = tagsList?[index].id;
                  Map<String, dynamic> tag = tagsList?[index].data() as Map<String, dynamic>;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1)
                    ),
                    child: ListTile(
                      title: Text(
                        tag['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddEditTags(
                                    docId: docId,
                                    tag: tag,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit)
                          ),
                          IconButton(
                            onPressed: () {
                              _tagFirestoreService.deleteTag(docId);
                              tagProvider.updateTagsList();
                            },
                            icon: const Icon(Icons.delete)
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FabTags(),
    );
  }
}
