import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/common/dimention.dart';
import 'package:task_manager/ui/enums/task_status.enum.dart';
import 'package:task_manager/ui/model/Task.dart';

class TaskItemTile extends StatelessWidget {
  final Task task;
  final Function(Task) onEdit;
  final Function(Task) onDelete;
  const TaskItemTile(
      {super.key,
      required this.task,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          task.status.isDone ? const Color.fromARGB(255, 210, 202, 202) : null,
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              onEdit(task);
            },
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Color.fromARGB(255, 219, 214, 214),
              child: Icon(
                Icons.edit,
                size: 17,
              ),
            ),
          ),
          kdSpace.width,
          GestureDetector(
            onTap: () {
              onDelete(task);
            },
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Color.fromARGB(255, 234, 160, 160),
              child: Icon(
                Icons.delete,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
