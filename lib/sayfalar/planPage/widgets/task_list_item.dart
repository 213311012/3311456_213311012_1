import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/main.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/data/local_storage.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/model/task_model.dart';
import 'package:intl/intl.dart';


class TaskListItem extends StatefulWidget {
  final Task task;
  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  TextEditingController _taskNameController = TextEditingController();
  late LocalStorage _localStorage;

  @override
  void initState() {
    _localStorage = locator<LocalStorage>();
    super.initState();
    _taskNameController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 10)
            ]),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              _localStorage.updateTask(task: widget.task);
              setState(() {});
            },
            child: Container(
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: widget.task.isCompleted ? Colors.green : Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.8),
                  shape: BoxShape.circle),
            ),
          ),
          title: widget.task.isCompleted
              ? Text(
                  widget.task.name,
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                )
              : TextField(
                  controller: _taskNameController,
                  minLines: 1,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (yeniDeger) {
                    if (yeniDeger.length > 2) {
                      widget.task.name = yeniDeger;
                      _localStorage.updateTask(task: widget.task);
                    }
                  },
                ),
          trailing: Text(
            DateFormat('dd.MM.yy').format(widget.task.createdAt),
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ));
  }
}
