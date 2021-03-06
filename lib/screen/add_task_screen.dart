import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_when/model/task_list_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final int parentid;

  const AddTaskBottomSheet({
    this.parentid,
    Key key,
  }) : super(key: key);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String text;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Container(
        height: 200,
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              onChanged: (value) {
                text = value;
              },
            ),
            ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                int newID = Provider.of<TaskListModel>(context, listen: false)
                        .getLastId +
                    1;
                setState(() {
                  Provider.of<TaskListModel>(context, listen: false).addTask(
                      {'id': newID, 'title': text, 'parent': widget.parentid});
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class addTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
