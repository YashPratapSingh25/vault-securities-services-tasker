import 'package:flutter/material.dart';

class TaskSearchTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function() onTap;
  const TaskSearchTextfield({super.key, required this.controller, required this.onTap});

  @override
  State<TaskSearchTextfield> createState() => _TaskSearchTextfieldState();
}

class _TaskSearchTextfieldState extends State<TaskSearchTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        onTapOutside: (event){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: widget.controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
            suffixIcon: GestureDetector(
              onTap: (){
                widget.onTap();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  border: Border.all(width: 0.6),
                ),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                ),
              ),
            ),
            hintText: "Search Tasks"
        )
    );
  }
}
