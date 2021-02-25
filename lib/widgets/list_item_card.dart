import 'package:flutter/material.dart';
import 'package:what_when/model/TaskModel.dart';

class ListItemCard extends StatelessWidget {
  final TaskModel task;

  const ListItemCard({
    this.task,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            '${task.title}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
