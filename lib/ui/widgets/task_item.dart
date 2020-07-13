import 'package:ToDODataBase/models/task_model.dart';
import 'package:ToDODataBase/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  Task task;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      key: ObjectKey(task),
      onDismissed: (direction) {
        Provider.of<DBProvider>(context, listen: false).deleteTask(task);
      },
      child: Card(
        child: ListTile(
          title: Text(task.title),
          leading: IconButton(
            
            icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<DBProvider>(context, listen: false).deleteTask(task);
        },
          ),
          trailing: Checkbox(
            value: task.isComplete,
            onChanged: (value) {
              Provider.of<DBProvider>(context, listen: false).updateTask(task);
            },
          ),
        ),
      ),
    );
  }
}
